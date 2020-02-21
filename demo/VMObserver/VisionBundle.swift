import Foundation
import MapboxVision

enum VisionPerformance {
    case high
    case medium
    case low
}

class VisionBundle {
    let videoSource: VideoSource
    let visionManager: BaseVisionManager

    private(set) var country: Country = .unknown

    var arBundle: VisionARBundle {
        if privateAR == nil {
            privateAR = VisionARBundle(self)
        }
        return privateAR!
    }
    private var privateAR: VisionARBundle?
    var safetyBundle: VisionSafetyBundle {
         if privateSafety == nil {
             privateSafety = VisionSafetyBundle(self)
         }
         return privateSafety!
    }
    private var privateSafety: VisionSafetyBundle?

    private var delegates: [WeakVisionManagerDegelate] = []

    static func createDefault() -> VisionBundle {
        let camera = CameraVideoSource()
        let visionManager = VisionManager.create(videoSource: camera)
        return VisionBundle(videoSource: camera, visionManager: visionManager)
    }

    init(videoSource: VideoSource, visionManager: BaseVisionManager) {
        self.videoSource = videoSource
        self.visionManager = visionManager
        if let visionManager = visionManager as? VisionManager {
            visionManager.delegate = self
        }
        if let replayManager = visionManager as? VisionReplayManager {
            replayManager.delegate = self
        }
    }

    func start() {
        if let visionManager = visionManager as? VisionManager {
            guard let camera = videoSource as? CameraVideoSource else { return }
            visionManager.start()
            camera.start()
        }
        if let replayManager = visionManager as? VisionReplayManager {
            replayManager.start()
        }
    }

    func stop() {
        if let visionManager = visionManager as? VisionManager {
            guard let camera = videoSource as? CameraVideoSource else { return }
            visionManager.stop()
            camera.stop()
        }
        if let replayManager = visionManager as? VisionReplayManager {
            replayManager.stop()
        }
    }

    func add(delegate: VisionManagerDelegate) {
        delegates.append(WeakVisionManagerDegelate(delegate))
    }

    func groomWeak() {
        delegates = delegates.filter { delegate in
            delegate.ref != nil
        }
    }

    func set(performance: VisionPerformance) {
        switch performance {
        case .high:
            visionManager.modelPerformanceConfig = .merged(performance: ModelPerformance(mode: .fixed, rate: .high))
        case .medium:
            visionManager.modelPerformanceConfig = .merged(performance: ModelPerformance(mode: .fixed, rate: .medium))
        case .low:
            visionManager.modelPerformanceConfig = .merged(performance: ModelPerformance(mode: .fixed, rate: .low))
        }
    }
}

extension VisionBundle: VisionManagerDelegate {
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateAuthorizationStatus authStatus: AuthorizationStatus) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateAuthorizationStatus: authStatus)
            }
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameSegmentation frameSegmentation: FrameSegmentation) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateFrameSegmentation: frameSegmentation)
            }
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameDetections frameDetections: FrameDetections) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateFrameDetections: frameDetections)
            }
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameSignClassifications frameSignClassifications: FrameSignClassifications) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateFrameSignClassifications: frameSignClassifications)
            }
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateRoadDescription roadDescription: RoadDescription) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateRoadDescription: roadDescription)
            }
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateWorldDescription worldDescription: WorldDescription) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateWorldDescription: worldDescription)
            }
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateVehicleState vehicleState: VehicleState) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateVehicleState: vehicleState)
            }
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateCamera camera: Camera) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateCamera: camera)
            }
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateCountry country: Country) {
        DispatchQueue.main.async { [weak self] in
            self?.country = country
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManager(visionManager, didUpdateCountry: country)
            }
        }
    }

    func visionManagerDidCompleteUpdate(_ visionManager: VisionManagerProtocol) {
        DispatchQueue.main.async { [weak self] in
            self?.delegates.forEach { delegate in
                delegate.ref?.visionManagerDidCompleteUpdate(visionManager)
            }
        }
    }
}

private class WeakVisionManagerDegelate {
    private(set) weak var ref: VisionManagerDelegate?

    init(_ visionDelegate: VisionManagerDelegate) {
        ref = visionDelegate
    }
}
