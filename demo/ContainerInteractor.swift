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

protocol CalibrationProgress {
    var isCalibrated: Bool { get }
    var calibrationProgress: Float { get }
}

extension Camera: CalibrationProgress {}

protocol ContainerPresenter: class {
    func presentVision()
    func present(screen: Screen)
    func presentBackButton(isVisible: Bool)
    
    func present(frame: CMSampleBuffer)
    func present(segmentation: FrameSegmentation)
    func present(detections: FrameDetections)
    
    func present(signs: [ImageAsset])
    func present(roadDescription: RoadDescription?)
//    func present(safetyState: SafetyState)
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
    
    private let signTracker = Tracker<Sign>(maxCapacity: signTrackerMaxCapacity)
    private var signTrackerUpdateTimer: Timer?
    
    private let alertPlayer: AlertPlayer
//    private var lastSafetyState = SafetyState.none
    private var lastSpeedLimitState: SpeedLimitState?
    
    private var speedLimitAlertRestriction = AutoResetRestriction(resetInterval: speedLimitAlertDelay)
    private var collisionAlertRestriction = AutoResetRestriction(resetInterval: collisionAlertDelay)
    
    // vision values caching
    private var calibrationProgress: CalibrationProgress?
    
    struct Dependencies {
        let alertPlayer: AlertPlayer
        let presenter: ContainerPresenter
    }
    
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        self.alertPlayer = dependencies.alertPlayer
        
        visionManager = VisionManager.create(videoSource: camera)
        
        camera.add(observer: self)
        visionManager.start(delegate: VisionDelegateProxy(delegate: self))
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
//        presenter.present(safetyState: .none)
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
    
//    private func check(_ speedLimit: SpeedLimit, at position: Position?) -> Bool {
//        guard let position = position else { return false }
//        return position.speed > speedLimit.maxSpeed
//    }
//
//    private func update(speedLimit: SpeedLimit?, position: Position?) {
//        guard
//            case .distanceToObject = currentScreen,
//            let speedLimit = speedLimit
//        else {
//            presenter.present(speedLimit: nil, isNew: false)
//            lastSpeedLimitState = nil
//            return
//        }
//
//        let isSpeeding = check(speedLimit, at: position)
//        let newState = SpeedLimitState(speedLimit: speedLimit, isSpeeding: isSpeeding)
//
//        guard newState != lastSpeedLimitState else { return }
//
//        presentSpeedLimit(oldState: lastSpeedLimitState, newState: newState)
//        playSpeedLimitAlert(oldState: lastSpeedLimitState, newState: newState)
//
//        lastSpeedLimitState = newState
//    }
    
//    private func presentSpeedLimit(oldState: SpeedLimitState?, newState: SpeedLimitState) {
//        let sign = getIcon(for: SignValue(type: .speedLimit, number: newState.speedLimit.maxSpeed), over: newState.isSpeeding)
//        let isNew = oldState == nil || oldState!.speedLimit != newState.speedLimit
//        presenter.present(speedLimit: sign, isNew: isNew)
//    }
    
    private func playSpeedLimitAlert(oldState: SpeedLimitState?, newState: SpeedLimitState) {
        let wasSpeeding = oldState?.isSpeeding ?? false
        let hasStartedSpeeding = newState.isSpeeding && !wasSpeeding
        
        if hasStartedSpeeding, speedLimitAlertRestriction.isAllowed {
            alertPlayer.play(sound: .overSpeedLimit, repeated: false)
            speedLimitAlertRestriction.restrict()
        }
    }
    
    private func getIcon(for sign: Sign, over: Bool) -> ImageAsset? {
        return sign.icon(over: over, country: visionManager.country)
    }
    
    deinit {
        visionManager.destroy()
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
            presenter.present(calibrationProgress: calibrationProgress)
        default: break
        }
        
        present(screen: screen)
    }
}

extension ContainerInteractor: VisionManagerDelegate {

    func visionManager(_ visionManager: VisionManager, didUpdateFrameSegmentation frameSegmentation: FrameSegmentation) {
        guard case .segmentation = currentScreen else { return }
        presenter.present(segmentation: frameSegmentation)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateFrameDetections frameDetections: FrameDetections) {
        guard case .objectDetection = currentScreen else { return }
        presenter.present(detections: frameDetections)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateFrameSigns frameSigns: FrameSigns) {
        guard case .signsDetection = currentScreen else { return }
        let items = frameSigns.signs.map({ $0.sign })
        signTracker.update(items)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateRoadDescription roadDescription: RoadDescription) {
        guard case .laneDetection = currentScreen else { return }
        presenter.present(roadDescription: roadDescription)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateCamera camera: Camera) {
        calibrationProgress = camera
        guard case .distanceToObject = currentScreen else { return }
        presenter.present(calibrationProgress: camera)
    }
    
//    func visionManager(_ visionManager: VisionManager, didUpdateLaneDepartureState laneDepartureState: LaneDepartureState) {
//        guard case .laneDetection = currentScreen else { return }
//
//        switch laneDepartureState {
//        case .normal, .warning:
//            alertPlayer.stop()
//        case .alert:
//            alertPlayer.play(sound: .laneDepartureWarning, repeated: true)
//        }
//
//        presenter.present(laneDepartureState: laneDepartureState)
//    }
    
//        func visionManager(_ visionManager: VisionManager, didUpdateWorldDescription worldDescription: WorldDescription) {
//            guard case .distanceToObject = currentScreen else {
//    //            presenter.present(safetyState: .none)
//                return
//            }
//
//            let state = SafetyState(worldDescription, canvasSize: visionManager.frameSize)
//
//            switch state {
//            case .none, .distance: break
//            case .collisions(let collisions, _):
//                let containsPerson = collisions.contains { $0.objectType == .person && $0.state == .critical }
//                if containsPerson, collisionAlertRestriction.isAllowed {
//                    alertPlayer.play(sound: .collisionAlertCritical, repeated: false)
//                    collisionAlertRestriction.restrict()
//                }
//            }
//    
//            presenter.present(safetyState: state)
//        }
    
//    func visionManager(_ visionManager: VisionManager, didUpdateEstimatedPosition estimatedPosition: Position?) {
//        update(speedLimit: visionManager.speedLimit, position: estimatedPosition)
//    }
}

//extension ContainerInteractor: VisionManagerRoadRestrictionsDelegate {
//    func visionManager(_ visionManager: VisionManager, didUpdateSpeedLimit speedLimit: SpeedLimit?) {
//        update(speedLimit: speedLimit, position: visionManager.estimatedPosition)
//    }
//}

extension ContainerInteractor: VideoSourceObserver {
    func videoSource(_ videoSource: VideoSource, didOutput videoSample: VideoSample) {
        presenter.present(frame: videoSample.buffer)
    }
}
