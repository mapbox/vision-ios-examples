//
//  DelegateProxy.swift
//  demo
//
//  Created by Alexander Pristavko on 3/7/19.
//  Copyright © 2019 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision
import MapboxVisionSafety
import MapboxVisionAR

class DelegateProxy<Delegate: AnyObject> {
    private weak var delegate: Delegate?
    private let queue: DispatchQueue
    
    init(delegate: Delegate, queue: DispatchQueue = .main) {
        self.delegate = delegate
        self.queue = queue
    }
}

extension DelegateProxy: VisionManagerDelegate where Delegate: VisionManagerDelegate {
    func visionManager(_ visionManager: VisionManager, didUpdateAuthorizationStatus authorizationStatus: AuthorizationStatus) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateAuthorizationStatus: authorizationStatus)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateFrameSegmentation frameSegmentation: FrameSegmentation) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateFrameSegmentation: frameSegmentation)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateFrameDetections frameDetections: FrameDetections) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateFrameDetections: frameDetections)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateFrameSignClassifications frameSignClassifications: FrameSignClassifications) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateFrameSignClassifications: frameSignClassifications)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateRoadDescription roadDescription: RoadDescription) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateRoadDescription: roadDescription)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateWorldDescription worldDescription: WorldDescription) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateWorldDescription: worldDescription)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateVehicleState vehicleState: VehicleState) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateVehicleState: vehicleState)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateCamera camera: Camera) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateCamera: camera)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateCountry country: Country) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateCountry: country)
        }
    }
    
    func visionManagerDidCompleteUpdate(_ visionManager: VisionManager) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManagerDidCompleteUpdate(visionManager)
        }
    }
}

extension DelegateProxy: VisionARManagerDelegate where Delegate: VisionARManagerDelegate {
    func visionARManager(_ visionARManager: VisionARManager, didUpdateARCamera camera: ARCamera) {
        queue.async { [unowned self] in
            self.delegate?.visionARManager(visionARManager, didUpdateARCamera: camera)
        }
    }
    
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
}
