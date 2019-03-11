//
//  SafetyState.swift
//  demo
//
//  Created by Maksim on 11/2/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import MapboxVisionCore

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
    
//    struct Collision: Equatable {
//
//        enum State {
//            case warning
//            case critical
//
//            init?(_ state: CollisionState) {
//                switch state {
//                case .notTriggered:
//                    return nil
//                case .warning:
//                    self = .warning
//                case .critical:
//                    self = .critical
//                }
//            }
//        }
//
//        let objectType: ObjectType
//        let state: State
//        let boundingBox: CGRect
//    }
//
//    case none
//    case distance(frame: CGRect, distance: Double, canvasSize: CGSize)
//    case collisions([Collision], canvasSize: CGSize)
//
//    init(_ worldDescription: WorldDescription, canvasSize: CGSize) {
//
//        let collisions = worldDescription.collisionObjects.compactMap { collision -> Collision? in
//
//            let type = collision.object.detection.objectType
//            let state = collision.state
//
//            guard
//                let objectType = ObjectType(type),
//                let collisionState = Collision.State(state)
//            else { return nil }
//
//            let boundingBox = collision.object.detection.boundingBox
//            return Collision(objectType: objectType, state: collisionState, boundingBox: boundingBox)
//        }
//
//        if collisions.count > 0 {
//            self = .collisions(collisions, canvasSize: canvasSize)
//        } else if let car = worldDescription.forwardCar {
//            let distance = max(0, car.distance - SafetyState.bonnetAdjustment)
//            self = .distance(frame: car.detection.boundingBox, distance: distance, canvasSize: canvasSize)
//        } else {
//            self = .none
//        }
//    }
}
