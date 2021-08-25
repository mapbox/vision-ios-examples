import CoreMedia
import Foundation
import MapboxVision
import MapboxVisionAR
import MapboxVisionSafety

enum Screen {
    case menu
    case signsDetection
    case segmentation
    case objectDetection
    case distanceToObject
    case laneDetection
    case arRouting
}

protocol CalibrationProgress {
    var isCalibrated: Bool { get }
    var calibrationProgress: Float { get }
}

extension Camera: CalibrationProgress {}

protocol ContainerPresenter: AnyObject {
    func presentVision()
    func present(screen: Screen)
    func presentBackButton(isVisible: Bool)

    func present(signs: [ImageAsset])
    func present(roadDescription: RoadDescription?)
    func present(safetyState: SafetyState)
    func present(calibrationProgress: CalibrationProgress?)
    func present(speedLimit: ImageAsset?, isNew: Bool)

    func inject(visionManager: VisionManagerProtocol, arManager: VisionARManager)

    func dismissCurrent()
}

protocol MenuDelegate: AnyObject {
    func selected(screen: Screen)
}

@objc protocol ContainerDelegate: AnyObject {
    func backButtonPressed()
    func didNavigationRouteUpdated(route: MapboxVisionAR.Route?)
}

private let signTrackerMaxCapacity = 5
private let collisionAlertDelay: TimeInterval = 3
private let speedLimitAlertDelay: TimeInterval = 5

final class ContainerInteractor {
    private struct SpeedLimitState: Equatable {
        let speedLimits: SpeedLimits
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
    private let visionManager: VisionManagerProtocol
    private var visionARManager: VisionARManager?
    private var visionSafetyManager: VisionSafetyManager?
    private let camera: VideoSource

    private lazy var delegateProxy = DelegateProxy(delegate: self)

    private let signTracker = Tracker<Sign>(maxCapacity: signTrackerMaxCapacity)
    private var signTrackerUpdateTimer: Timer?

    private let alertPlayer: AlertPlayer
    private var lastSafetyState = SafetyState.none
    private var lastSpeedLimitState: SpeedLimitState?

    private var speedLimitAlertRestriction = AutoResetRestriction(resetInterval: speedLimitAlertDelay)
    private var collisionAlertRestriction = AutoResetRestriction(resetInterval: collisionAlertDelay)

    // vision values caching
    private var calibrationProgress: CalibrationProgress?

    private var speedLimits: SpeedLimits?
    private var currentSpeed: Float?
    private var currentCountry: Country = .unknown

    struct Dependencies {
        let alertPlayer: AlertPlayer
        let presenter: ContainerPresenter
    }

    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        self.alertPlayer = dependencies.alertPlayer

        let camera = CameraVideoSource()
        camera.start()
        let visionManager = VisionManager.create(videoSource: camera)

        self.camera = camera
        self.visionManager = visionManager

        let visionARManager = VisionARManager.create(visionManager: visionManager)
        self.visionARManager = visionARManager
        visionSafetyManager = VisionSafetyManager.create(visionManager: visionManager)
        visionSafetyManager?.delegate = delegateProxy

        visionManager.delegate = delegateProxy
        visionManager.start()

        presenter.inject(visionManager: visionManager, arManager: visionARManager)
        presenter.presentVision()
        present(screen: .menu)
    }

    private func scheduleSignTrackerUpdates() {
        stopSignTrackerUpdates()

        signTrackerUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let signs = self.signTracker.getCurrent().compactMap { self.getIcon(for: $0, over: false) }
            self.presenter.present(signs: signs)
        }
    }

    private func stopSignTrackerUpdates() {
        signTrackerUpdateTimer?.invalidate()
        signTracker.reset()
    }

    private func modelPerformance(for screen: Screen) -> ModelPerformance {
        switch screen {
        case .signsDetection, .segmentation, .objectDetection:
            return ModelPerformance(mode: .fixed, rate: .high)
        case .distanceToObject, .laneDetection:
            return ModelPerformance(mode: .fixed, rate: .medium)
        case .menu, .arRouting:
            return ModelPerformance(mode: .fixed, rate: .low)
        }
    }

    private func resetPresentation() {
        stopSignTrackerUpdates()
        alertPlayer.stop()
        presenter.present(signs: [])
        presenter.present(roadDescription: nil)
        presenter.present(safetyState: .none)
        presenter.present(calibrationProgress: nil)
        presenter.present(speedLimit: nil, isNew: false)
    }

    private func present(screen: Screen) {
        presenter.dismissCurrent()
        visionManager.modelPerformance = modelPerformance(for: screen)
        presenter.present(screen: screen)
        presenter.presentBackButton(isVisible: screen != .menu)
        currentScreen = screen
    }

    private func updateSpeedLimits() {
        guard
            case .distanceToObject = currentScreen,
            let speedLimits = speedLimits,
            let speed = currentSpeed
        else {
            presenter.present(speedLimit: nil, isNew: false)
            lastSpeedLimitState = nil
            return
        }

        let isSpeeding = speed > speedLimits.speedLimitRange.max
        let newState = SpeedLimitState(speedLimits: speedLimits, isSpeeding: isSpeeding)

        guard newState != lastSpeedLimitState else { return }

        presentSpeedLimit(oldState: lastSpeedLimitState, newState: newState)
        playSpeedLimitAlert(oldState: lastSpeedLimitState, newState: newState)

        lastSpeedLimitState = newState
    }

    private func presentSpeedLimit(oldState: SpeedLimitState?, newState: SpeedLimitState) {
        let sign = getIcon(for: Sign(type: .speedLimit, number: newState.speedLimits.speedLimitRange.max), over: newState.isSpeeding)
        let isNew = oldState == nil || oldState!.speedLimits != newState.speedLimits
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

    private func getIcon(for sign: Sign, over: Bool) -> ImageAsset? {
        return sign.icon(over: over, country: currentCountry)
    }
}

extension ContainerInteractor: ContainerDelegate {
    func backButtonPressed() {
        resetPresentation()
        present(screen: .menu)
    }

    func didNavigationRouteUpdated(route: MapboxVisionAR.Route?) {
        if let route = route {
            visionARManager?.set(route: route)
        }
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
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameSignClassifications frameSignClassifications: FrameSignClassifications) {
        guard case .signsDetection = currentScreen else { return }
        let items = frameSignClassifications.signs.map { $0.sign }
        signTracker.update(items)
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateVehicleState vehicleState: VehicleState) {
        guard case .distanceToObject = currentScreen else { return }
        currentSpeed = vehicleState.speed
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateRoadDescription roadDescription: RoadDescription) {
        guard case .laneDetection = currentScreen else { return }
        presenter.present(roadDescription: roadDescription)
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateCamera camera: Camera) {
        calibrationProgress = camera
        guard case .distanceToObject = currentScreen else { return }
        presenter.present(calibrationProgress: camera)
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateCountry country: Country) {
        currentCountry = country
    }

    func visionManagerDidCompleteUpdate(_ visionManager: VisionManagerProtocol) {
        updateSpeedLimits()
    }
}

import AVFoundation

extension ContainerInteractor: VisionSafetyManagerDelegate {
    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didDetectImpact: ImpactDetection) {
        print("Impact detected")
        AudioServicesPlaySystemSound(SystemSoundID(1016))
    }

    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateRoadRestrictions roadRestrictions: RoadRestrictions) {
        speedLimits = roadRestrictions.speedLimits
    }

    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateCollisions collisions: [CollisionObject]) {
        guard case .distanceToObject = currentScreen else {
            presenter.present(safetyState: .none)
            return
        }

        let state = SafetyState(collisions)

        switch state {
        case .none: break
        case .collisions(let collisions):
            let containsPerson = collisions.contains { $0.objectType == .person && $0.state == .critical }
            if containsPerson, collisionAlertRestriction.isAllowed {
                alertPlayer.play(sound: .collisionAlertCritical, repeated: false)
                collisionAlertRestriction.restrict()
            }
        }

        presenter.present(safetyState: state)
    }
}
