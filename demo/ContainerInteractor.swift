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

protocol ContainerPresenter: class {
    func presentVision()
    func present(screen: Screen)
    func presentBackButton(isVisible: Bool)
    
    func present(frame: CMSampleBuffer)
    func present(segmentation: SegmentationMask)
    func present(detections: Detections)
    
    func present(signs: [ImageAsset])
    func present(roadDescription: RoadDescription?)
    func present(safetyState: SafetyState)
    func present(laneDepartureState: LaneDepartureState)
    func present(calibrationProgress: CalibrationProgress?)
    func present(speedLimit: ImageAsset?, isNew: Bool)
    
    func dismissCurrent()
}

protocol MenuDelegate: class {
    func selected(screen: Screen)
}

@objc protocol ContainerDelegate: class {
    func backButtonPressed()
}

private let signTrackerMaxCapacity = 5
private let collisionAlertDelay: TimeInterval = 3
private let speedLimitAlertDelay: TimeInterval = 5

final class ContainerInteractor {
    
    private struct SpeedLimitState: Equatable {
        let speedLimit: SpeedLimit
        let isSpeeding: Bool
    }
    
    private class AutoResetRestriction {
        var isAllowed: Bool = true
        
        private let resetInterval: TimeInterval
        
        private var timer: Timer?
        
        init(resetInterval: TimeInterval) {
            self.resetInterval = resetInterval
        }
        
        func restrict() {
            isAllowed = false
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: resetInterval, repeats: false) { [weak self] _ in
                self?.isAllowed = true
            }
        }
    }
    
    private var currentScreen = Screen.menu
    private let presenter: ContainerPresenter
    private let visionManager: VisionManager
    private let camera = CameraVideoSource()
    
    private let signTracker = Tracker<SignValue>(maxCapacity: signTrackerMaxCapacity)
    private var signTrackerUpdateTimer: Timer?
    
    private let alertPlayer: AlertPlayer
    private var lastSafetyState = SafetyState.none
    private var lastSpeedLimitState: SpeedLimitState?
    
    private var speedLimitAlertRestriction = AutoResetRestriction(resetInterval: speedLimitAlertDelay)
    private var collisionAlertRestriction = AutoResetRestriction(resetInterval: collisionAlertDelay)
    
    struct Dependencies {
        let alertPlayer: AlertPlayer
        let presenter: ContainerPresenter
    }
    
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        self.alertPlayer = dependencies.alertPlayer
        
        visionManager = VisionManager.shared
        visionManager.delegate = self
        visionManager.roadRestrictionsDelegate = self
        
        camera.add(observer: self)
        visionManager.initialize(videoSource: camera)
        visionManager.start()
        camera.start()
        
        presenter.presentVision()
        present(screen: .menu)
    }
    
    private func scheduleSignTrackerUpdates() {
        stopSignTrackerUpdates()
        
        signTrackerUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            let signs = self.signTracker.getCurrent().compactMap { self.getIcon(for: $0, over: false) }
            self.presenter.present(signs: signs)
        }
    }
    
    private func stopSignTrackerUpdates() {
        signTrackerUpdateTimer?.invalidate()
        signTracker.reset()
    }
    
    private func modelPerformanceConfig(for screen: Screen) -> ModelPerformanceConfig {
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
    
    private func resetPresentation() {
        stopSignTrackerUpdates()
        alertPlayer.stop()
        presenter.present(signs: [])
        presenter.present(roadDescription: nil)
        presenter.present(laneDepartureState: .normal)
        presenter.present(safetyState: .none)
        presenter.present(calibrationProgress: nil)
        presenter.present(speedLimit: nil, isNew: false)
    }
    
    private func present(screen: Screen) {
        presenter.dismissCurrent()
        visionManager.modelPerformanceConfig = modelPerformanceConfig(for: screen)
        presenter.present(screen: screen)
        presenter.presentBackButton(isVisible: screen != .menu)
        currentScreen = screen
    }
    
    private func check(_ speedLimit: SpeedLimit, at position: Position?) -> Bool {
        guard let position = position else { return false }
        return position.speed > speedLimit.maxSpeed
    }
    
    private func update(speedLimit: SpeedLimit?, position: Position?) {
        guard
            case .distanceToObject = currentScreen,
            let speedLimit = speedLimit
        else {
            presenter.present(speedLimit: nil, isNew: false)
            lastSpeedLimitState = nil
            return
        }
        
        let isSpeeding = check(speedLimit, at: position)
        let newState = SpeedLimitState(speedLimit: speedLimit, isSpeeding: isSpeeding)
        
        guard newState != lastSpeedLimitState else { return }
        
        presentSpeedLimit(oldState: lastSpeedLimitState, newState: newState)
        playSpeedLimitAlert(oldState: lastSpeedLimitState, newState: newState)
        
        lastSpeedLimitState = newState
    }
    
    private func presentSpeedLimit(oldState: SpeedLimitState?, newState: SpeedLimitState) {
        let sign = getIcon(for: SignValue(type: .speedLimit, number: newState.speedLimit.maxSpeed), over: newState.isSpeeding)
        let isNew = oldState == nil || oldState!.speedLimit != newState.speedLimit
        presenter.present(speedLimit: sign, isNew: isNew)
    }
    
    private func playSpeedLimitAlert(oldState: SpeedLimitState?, newState: SpeedLimitState) {
        let wasSpeeding = oldState?.isSpeeding ?? false
        let hasStartedSpeeding = newState.isSpeeding && !wasSpeeding
        
        if hasStartedSpeeding, speedLimitAlertRestriction.isAllowed {
            alertPlayer.play(sound: .overSpeedLimit, repeated: false)
            speedLimitAlertRestriction.restrict()
        }
    }
    
    private func getIcon(for sign: SignValue, over: Bool) -> ImageAsset? {
        return sign.icon(over: over, country: VisionManager.shared.country)
    }
    
    deinit {
        visionManager.shutdown()
        camera.remove(observer: self)
    }
}

extension ContainerInteractor: ContainerDelegate {
    
    func backButtonPressed() {
        resetPresentation()
        present(screen: .menu)
    }
}

extension ContainerInteractor: MenuDelegate {
    
    func selected(screen: Screen) {
        switch screen {
        case .signsDetection:
            scheduleSignTrackerUpdates()
        case .distanceToObject:
            presenter.present(calibrationProgress: visionManager.calibrationProgress)
        default: break
        }
        
        present(screen: screen)
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
        guard
            case .segmentation = currentScreen,
            let segmentation = segmentation
        else { return }
        presenter.present(segmentation: segmentation)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateDetections detections: Detections?) {
        guard
            case .objectDetection = currentScreen,
            let detections = detections
        else { return }
        presenter.present(detections: detections)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateSignClassifications classifications: SignClassifications?) {
        guard
            case .signsDetection = currentScreen,
            let items = classifications?.items.map({ $0.value })
        else { return }
        signTracker.update(items)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateRawRoadDescription roadDescription: RoadDescription?) {}
    
    func visionManager(_ visionManager: VisionManager, didUpdateRoadDescription roadDescription: RoadDescription?) {
        guard case .laneDetection = currentScreen else { return }
        presenter.present(roadDescription: roadDescription)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateEstimatedPosition estimatedPosition: Position?) {
        update(speedLimit: visionManager.speedLimit, position: estimatedPosition)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateWorldDescription worldDescription: WorldDescription?) {
        guard case .distanceToObject = currentScreen, let worldDescription = worldDescription else {
            presenter.present(safetyState: .none)
            return
        }
        
        let state = SafetyState(worldDescription, canvasSize: visionManager.frameSize)
        
        switch state {
        case .none, .distance: break
        case .collisions(let collisions, _):
            let containsPerson = collisions.contains { $0.objectType == .person && $0.state == .critical }
            if containsPerson, collisionAlertRestriction.isAllowed {
                alertPlayer.play(sound: .collisionAlertCritical, repeated: false)
                collisionAlertRestriction.restrict()
            }
        }
        
        presenter.present(safetyState: state)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateCalibrationProgress calibrationProgress: CalibrationProgress) {
        guard case .distanceToObject = currentScreen else { return }
        presenter.present(calibrationProgress: calibrationProgress)
    }
}

extension ContainerInteractor: VisionManagerRoadRestrictionsDelegate {
    func visionManager(_ visionManager: VisionManager, didUpdateSpeedLimit speedLimit: SpeedLimit?) {
        update(speedLimit: speedLimit, position: visionManager.estimatedPosition)
    }
}

extension ContainerInteractor: VideoSourceObserver {
    func videoSource(_ videoSource: VideoSource, didOutput videoSample: VideoSample) {
        presenter.present(frame: videoSample.buffer)
    }
}
