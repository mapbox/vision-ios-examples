//
//  ContainerInteractor.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision

enum Screen {
    case menu
    case signsDetection
    case segmentation
    case objectDetection
    case distanceToObject
    case map
    case laneDetection
    case arRouting
}

enum DistanceToObjectScreenState {
    case none
    case distance(frame: CGRect, distance: Double, canvasSize: CGSize)
    case warning(frame: CGRect, canvasSize: CGSize)
    case alert
}

protocol ContainerPresenter: class {
    func presentVision()
    func present(screen: Screen)
    func presentBackButton(isVisible: Bool)
    
    func present(signs: [ImageAsset])
    func present(roadDescription: RoadDescription?)
    func present(distanceToObjectState: DistanceToObjectScreenState)
    func present(laneDepartureState: LaneDepartureState)
    func present(calibrationProgress: CalibrationProgress?)
    
    func dismissMenu()
    func dismissCurrent()
}

protocol MenuDelegate: class {
    func selected(screen: Screen)
}

@objc protocol ContainerDelegate: class {
    func backButtonPressed()
}

private let signTrackerMaxCapacity = 5

final class ContainerInteractor {
    
    private var currentScreen = Screen.menu
    private let presenter: ContainerPresenter
    private let visionManager: VisionManager
    
    private let signTracker = Tracker<SignValue>(maxCapacity: signTrackerMaxCapacity)
    private var signTrackerUpdateTimer: Timer?
    
    private let alertPlayer = AlertPlayer()
    private var lastCollisionState = CollisionState.notTriggered
    
    init(presenter: ContainerPresenter) {
        self.presenter = presenter
        
        visionManager = VisionManager.shared
        visionManager.delegate = self
        visionManager.start()
        
        resetPerformance()
        
        presenter.presentBackButton(isVisible: false)
        presenter.presentVision()
        presenter.present(screen: .menu)
    }
    
    private func scheduleSignTrackerUpdates() {
        stopSignTrackerUpdates()
        
        signTrackerUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            let signs = self.signTracker.getCurrent().compactMap { sign in
                return sign.icon(over: false, market: .us)
            }
            self.presenter.present(signs: signs)
        }
    }
    
    private func stopSignTrackerUpdates() {
        signTrackerUpdateTimer?.invalidate()
        signTracker.reset()
    }
    
    private func resetPerformance() {
        let segmentationPerformance = ModelPerformance(mode: .fixed, rate: .low)
        let detectionPerformance = ModelPerformance(mode: .fixed, rate: .low)
        visionManager.modelPerformanceConfig = .separate(segmentationPerformance: segmentationPerformance,
                                                         detectionPerformance: detectionPerformance)
    }
    
    private func resetPresentation() {
        stopSignTrackerUpdates()
        alertPlayer.stop()
        presenter.present(signs: [])
        presenter.present(roadDescription: nil)
        presenter.present(laneDepartureState: .normal)
        presenter.present(distanceToObjectState: .none)
        presenter.present(calibrationProgress: nil)
    }
    
    deinit {
        visionManager.stop()
    }
}

extension ContainerInteractor: ContainerDelegate {
    
    func backButtonPressed() {
        presenter.dismissCurrent()
        presenter.presentBackButton(isVisible: false)
        presenter.present(screen: .menu)
        
        resetPresentation()
        resetPerformance()
        
        currentScreen = .menu
    }
}

extension ContainerInteractor: MenuDelegate {
    
    func selected(screen: Screen) {
        presenter.dismissCurrent()
        presenter.dismissMenu()
        
        switch screen {
        case .signsDetection:
            scheduleSignTrackerUpdates()
        case .distanceToObject:
            presenter.present(calibrationProgress: visionManager.calibrationProgress)
        default: break
        }
        
        let segmentationPerformance: ModelPerformance
        let detectionPerformance: ModelPerformance
        
        switch screen {
        case .signsDetection, .objectDetection:
            segmentationPerformance = ModelPerformance(mode: .fixed, rate: .low)
            detectionPerformance = ModelPerformance(mode: .fixed, rate: .high)
        case .segmentation:
            segmentationPerformance = ModelPerformance(mode: .fixed, rate: .high)
            detectionPerformance = ModelPerformance(mode: .fixed, rate: .low)
        case .distanceToObject, .laneDetection:
            segmentationPerformance = ModelPerformance(mode: .fixed, rate: .medium)
            detectionPerformance = ModelPerformance(mode: .fixed, rate: .medium)
        case .map, .menu, .arRouting:
            segmentationPerformance = ModelPerformance(mode: .fixed, rate: .low)
            detectionPerformance = ModelPerformance(mode: .fixed, rate: .low)
        }
        
        visionManager.modelPerformanceConfig = .separate(segmentationPerformance: segmentationPerformance,
                                                         detectionPerformance: detectionPerformance)
        
        presenter.present(screen: screen)
        presenter.presentBackButton(isVisible: true)
        currentScreen = screen
    }
}

extension ContainerInteractor: VisionManagerDelegate {
    func visionManager(_ visionManager: VisionManager, didUpdateLaneDepartureState laneDepartureState: LaneDepartureState) {
        guard case .laneDetection = currentScreen else { return }
        
        switch laneDepartureState {
        case .normal, .warning:
            alertPlayer.stop()
        case .alert:
            alertPlayer.play(sound: .laneDepartureWarning, repeated: true)
        }
        
        presenter.present(laneDepartureState: laneDepartureState)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateSegmentation segmentation: SegmentationMask?) {
        
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateDetections detections: Detections?) {
        
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateSignClassifications classifications: SignClassifications?) {
        guard case .signsDetection = currentScreen, let items = classifications?.items.map({ $0.value }) else { return }
        signTracker.update(items)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateRawRoadDescription roadDescription: RoadDescription?) {
    
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateRoadDescription roadDescription: RoadDescription?) {
        guard case .laneDetection = currentScreen else { return }
        presenter.present(roadDescription: roadDescription)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateEstimatedPosition estimatedPosition: Position?) {
        
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateWorldDescription worldDescription: WorldDescription?) {
        
        guard
            case .distanceToObject = currentScreen,
            let worldDescription = worldDescription,
            let car = worldDescription.collisionObjects.first,
            car.object.detection.objectType == .car
        else {
            presenter.present(distanceToObjectState: .none)
            alertPlayer.stop()
            return
        }
        
        switch car.state {
        case .notTriggered:
            presenter.present(distanceToObjectState: .distance(
                frame: car.object.detection.boundingBox,
                distance: car.object.distance,
                canvasSize: visionManager.frameSize
            ))
        case .warning:
            presenter.present(distanceToObjectState: .warning(
                frame: car.object.detection.boundingBox,
                canvasSize: visionManager.frameSize
            ))
        case .critical:
            presenter.present(distanceToObjectState: .alert)
        }
        
        playCollisionAlert(for: car.state)
    }
    
    private func playCollisionAlert(for state: CollisionState) {
        guard lastCollisionState != state else { return }
        
        switch state {
        case .notTriggered:
            alertPlayer.stop()
        case .warning:
            alertPlayer.play(sound: .collisionAlertWarning, repeated: true)
        case .critical:
            alertPlayer.play(sound: .collisionAlertCritical, repeated: true)
        }
        
        lastCollisionState = state
    }
    
    public func visionManager(_ visionManager: VisionManager, didUpdateCalibrationProgress calibrationProgress: CalibrationProgress) {
        guard case .distanceToObject = currentScreen else { return }
        presenter.present(calibrationProgress: calibrationProgress)
    }
}
