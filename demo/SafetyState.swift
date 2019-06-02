import Foundation
import MapboxVisionSafety

enum SafetyState: Equatable {

    public static let bonnetAdjustment = 1.25

    enum ObjectType {
        case car
        case person

        init?(_ type: DetectionClass) {
            switch type {
            case .trafficLight, .trafficSign, .bicycle:
                return nil
            case .car:
                self = .car
            case .person:
                self = .person
            }
        }
    }

    struct Collision: Equatable {

        enum State {
            case warning
            case critical

            init?(_ level: CollisionDangerLevel) {
                switch level {
                case .none:
                    return nil
                case .warning:
                    self = .warning
                case .critical:
                    self = .critical
                }
            }
        }

        let objectType: ObjectType
        let state: State
        let boundingBox: CGRect
        let imageSize: ImageSize
    }

    case none
    case collisions([Collision])

    init(_ collisionObjects: [CollisionObject]) {

        let collisions = collisionObjects.compactMap { collision -> Collision? in

            let type = collision.object.detectionClass
            let level = collision.dangerLevel

            guard
                let objectType = ObjectType(type),
                let collisionState = Collision.State(level)
            else { return nil }

            let boundingBox = collision.lastDetection.boundingBox
            let imageSize = collision.lastFrame.image.size
            return Collision(objectType: objectType,
                             state: collisionState,
                             boundingBox: boundingBox,
                             imageSize: imageSize)
        }

        if collisions.count > 0 {
            self = .collisions(collisions)
        } else {
            self = .none
        }
    }
}
