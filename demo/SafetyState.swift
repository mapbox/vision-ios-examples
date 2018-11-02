//
//  SafetyState.swift
//  demo
//
//  Created by Maksim on 11/2/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision

enum SafetyState {
    
    enum Object {
        case car(CGRect)
        case person(CGRect)
    }
    
    enum Collision {
        case warning(Object)
        case critical(Object)
    }
    
    case none
    case distance(frame: CGRect, distance: Double)
    case collisions([Collision])
    
    var canvasSize: CGSize {
        return VisionManager.shared.frameSize
    }
    
    init(_ worldDescription: WorldDescription) {
        
        let collisions = worldDescription.collisionObjects.compactMap { collision -> Collision? in
            let bbox = collision.object.detection.boundingBox
            let type = collision.object.detection.objectType
            let state = collision.state
            
            switch (type, state) {
            case (.lights, _), (.sign, _), (.bicycle, _), (_, .notTriggered):
                return nil
            case (.car, .warning):
                return .warning(.car(bbox))
            case (.car, .critical):
                return .critical(.car(bbox))
            case (.person, .warning):
                return .warning(.person(bbox))
            case (.person, .critical):
                return .critical(.person(bbox))
            }
        }
        
        if collisions.count > 0 {
            self = .collisions(collisions)
        } else if let car = worldDescription.getForwardCar() {
            self = .distance(frame: car.detection.boundingBox, distance: car.distance)
        } else {
            self = .none
        }
    }
}

extension SafetyState: Equatable {

    static func == (lhs: SafetyState, rhs: SafetyState) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case let (.distance(l), .distance(r)):
            return l.0 == r.0 && l.1 == r.1
        case let (.collisions(l), .collisions(r)):
            return l == r
        case (.none, _), (.distance, _), (.collisions, _):
            return false
        }
    }
}

extension SafetyState.Collision: Equatable {
    
    static func == (lhs: SafetyState.Collision, rhs: SafetyState.Collision) -> Bool {
        switch (lhs, rhs) {
        case let (.warning(l), .warning(r)):
            return l == r
        case let (.critical(l), .critical(r)):
            return l == r
        case (.warning, _), (.critical, _):
            return false
        }
    }
}

extension SafetyState.Object: Equatable { }
