import Foundation
import MapboxVisionSafety

class VisionSafetyBundle {
    let safetyManager: VisionSafetyManager
    private var delegates: [WeakVisionManagerDegelate] = []

    init(_ visionBundle: VisionBundle) {
        safetyManager = VisionSafetyManager.create(visionManager: visionBundle.visionManager)
    }

    func add(delegate: VisionSafetyManagerDelegate) {
        delegates.append(WeakVisionManagerDegelate(delegate))
    }

    func groomWeak() {
        delegates = delegates.filter { delegate in
            delegate.ref != nil
        }
    }
}

extension VisionSafetyBundle: VisionSafetyManagerDelegate {
    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateRoadRestrictions roadRestrictions: RoadRestrictions) {
        DispatchQueue.main.async {
            self.delegates.forEach { delegate in
                delegate.ref?.visionSafetyManager(visionSafetyManager, didUpdateRoadRestrictions: roadRestrictions)
            }
        }
    }

    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateCollisions collisions: [CollisionObject]) {
        DispatchQueue.main.async {
            self.delegates.forEach { delegate in
                delegate.ref?.visionSafetyManager(visionSafetyManager, didUpdateCollisions: collisions)
            }
        }
    }
}

private class WeakVisionManagerDegelate {
    weak private(set) var ref: VisionSafetyManagerDelegate?

    init(_ visionDelegate: VisionSafetyManagerDelegate) {
        ref = visionDelegate
    }
}
