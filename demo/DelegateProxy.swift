import Foundation
import MapboxVision
import MapboxVisionAR
import MapboxVisionSafety

class DelegateProxy<Delegate: AnyObject> {
    private weak var delegate: Delegate?
    private let queue: DispatchQueue

    init(delegate: Delegate, queue: DispatchQueue = .main) {
        self.delegate = delegate
        self.queue = queue
    }
}

extension DelegateProxy: VisionManagerDelegate where Delegate: VisionManagerDelegate {
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateAuthorizationStatus authorizationStatus: AuthorizationStatus) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateAuthorizationStatus: authorizationStatus)
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameSegmentation frameSegmentation: FrameSegmentation) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateFrameSegmentation: frameSegmentation)
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameDetections frameDetections: FrameDetections) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateFrameDetections: frameDetections)
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameSignClassifications frameSignClassifications: FrameSignClassifications) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateFrameSignClassifications: frameSignClassifications)
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateRoadDescription roadDescription: RoadDescription) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateRoadDescription: roadDescription)
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateWorldDescription worldDescription: WorldDescription) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateWorldDescription: worldDescription)
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateVehicleState vehicleState: VehicleState) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateVehicleState: vehicleState)
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateCamera camera: Camera) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateCamera: camera)
        }
    }

    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateCountry country: Country) {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateCountry: country)
        }
    }

    func visionManagerDidCompleteUpdate(_ visionManager: VisionManagerProtocol) {
        queue.async { [unowned self] in
            self.delegate?.visionManagerDidCompleteUpdate(visionManager)
        }
    }
}

extension DelegateProxy: VisionARManagerDelegate where Delegate: VisionARManagerDelegate {
    func visionARManager(_ visionARManager: VisionARManager, didUpdateARLane lane: ARLane?) {
        queue.async { [unowned self] in
            self.delegate?.visionARManager(visionARManager, didUpdateARLane: lane)
        }
    }
}

extension DelegateProxy: VisionSafetyManagerDelegate where Delegate: VisionSafetyManagerDelegate {
    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateRoadRestrictions roadRestrictions: RoadRestrictions) {
        queue.async { [unowned self] in
            self.delegate?.visionSafetyManager(visionSafetyManager, didUpdateRoadRestrictions: roadRestrictions)
        }
    }

    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateCollisions collisions: [CollisionObject]) {
        queue.async { [unowned self] in
            self.delegate?.visionSafetyManager(visionSafetyManager, didUpdateCollisions: collisions)
        }
    }

    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didDetectImpact: ImpactDetection) {
        queue.async { [unowned self] in
            self.delegate?.visionSafetyManager(visionSafetyManager, didDetectImpact: didDetectImpact)
        }
    }
}
