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

enum SafetyState {
    
    struct Warning {
        let frame: CGRect
        let objectType: ObjectType
    }
    
    case none
    case distance(frame: CGRect, distance: Double, canvasSize: CGSize)
    case warnings(values: [Warning], canvasSize: CGSize)
    case alert
}

protocol ContainerPresenter: class {
    func presentVision()
    func present(screen: Screen)
    func presentBackButton(isVisible: Bool)
    
    func present(signs: [ImageAsset])
    func present(roadDescription: RoadDescription?)
    func present(safetyState: SafetyState)
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
    
    private let signTracker = Tracker<SignClassification>(maxCapacity: signTrackerMaxCapacity)
    private var signTrackerUpdateTimer: Timer?
    
    private let alertPlayer: AlertPlayer
    private var lastSafetyState = SafetyState.none
    
    struct Dependencies {
        let alertPlayer: AlertPlayer
        let presenter: ContainerPresenter
    }
    
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        self.alertPlayer = dependencies.alertPlayer
        
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
        presenter.present(safetyState: .none)
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
    
    private func modelPerformanceConfig(_ screen: Screen) -> ModelPerformanceConfig {
        switch screen {
        case .signsDetection, .objectDetection:
            return .merged(performance: ModelPerformance(mode: .fixed, rate: .high))
        case .segmentation:
            return .separate(segmentationPerformance: ModelPerformance(mode: .fixed, rate: .high),
                             detectionPerformance: ModelPerformance(mode: .fixed, rate: .low))
        case .distanceToObject, .laneDetection:
            return .merged(performance: ModelPerformance(mode: .fixed, rate: .medium))
        case .map, .menu, .arRouting:
            return .merged(performance: ModelPerformance(mode: .fixed, rate: .low))
        }
    }
    
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
        
        visionManager.modelPerformanceConfig = modelPerformanceConfig(screen)
        
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
        guard case .signsDetection = currentScreen, let items = classifications?.items else { return }
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
        
        var safetyState: SafetyState = .none
        
        defer {
            presenter.present(safetyState: safetyState)
            playCollisionAlert(for: safetyState)
        }
        
        guard case .distanceToObject = currentScreen, let worldDescription = worldDescription else { return }
        
        let supportedCollisionObjects = worldDescription.collisionObjects
            .filter { $0.object.detection.objectType.isSupportedForCollisionWarning }
        let hasCriticalState = supportedCollisionObjects.contains { $0.state == .critical }
        let warningCollisions = supportedCollisionObjects.filter { $0.state == .warning }.map { $0.object.detection }
        let forwardCar = worldDescription.getForwardCar()
       
        if hasCriticalState {
            safetyState = .alert
        } else if warningCollisions.count > 0 {
            let warnings = warningCollisions.map { SafetyState.Warning(frame: $0.boundingBox, objectType: $0.objectType) }
            safetyState = .warnings(values: warnings, canvasSize: visionManager.frameSize)
        } else if let car = forwardCar {
            safetyState = .distance(frame: car.detection.boundingBox, distance: car.distance, canvasSize: visionManager.frameSize)
        }
    }
    
    private func playCollisionAlert(for state: SafetyState) {
        guard !lastSafetyState.isEqualIgnoringPayload(state) else { return }
        
        switch state {
        case .none, .distance:
            alertPlayer.stop()
        case .warnings:
            alertPlayer.play(sound: .collisionAlertWarning, repeated: true)
        case .alert:
            alertPlayer.play(sound: .collisionAlertCritical, repeated: true)
        }
        
        lastSafetyState = state
    }
    
    public func visionManager(_ visionManager: VisionManager, didUpdateCalibrationProgress calibrationProgress: CalibrationProgress) {
        guard case .distanceToObject = currentScreen else { return }
        presenter.present(calibrationProgress: calibrationProgress)
    }
}

private extension ObjectType {
    var isSupportedForCollisionWarning: Bool {
        switch self {
        case .lights, .sign:
            return false
        case .car, .person, .bicycle:
            return true
        }
    }
}

extension SafetyState {
    func isEqualIgnoringPayload(_ state: SafetyState) -> Bool {
        switch (self, state) {
        case (.none, .none), (.distance, .distance), (.warnings, .warnings), (.alert, .alert): return true
        case (.none, _), (.distance, _), (.warnings, _), (.alert, _): return false
        }
    }
}

extension SafetyState: Equatable {
    static func == (lhs: SafetyState, rhs: SafetyState) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none), (.alert, .alert):
            return true
        case let (.distance(lframe, ldistance, lcanvasSize), .distance(rframe, rdistance, rcanvasSize)):
            return lframe == rframe && ldistance == rdistance && lcanvasSize == rcanvasSize
        case let (.warnings(lvalues, lcanvasSize), .warnings(rvalues, rcanvasSize)):
            return lvalues == rvalues && lcanvasSize == rcanvasSize
        case (.none, _), (.distance, _), (.warnings, _), (.alert, _):
            return false
        }
    }
}

extension SafetyState.Warning: Equatable {
    static func == (lhs: SafetyState.Warning, rhs: SafetyState.Warning) -> Bool {
        return lhs.frame == rhs.frame && lhs.objectType == rhs.objectType
    }
}

