//
//  VisionDelegateProxy.swift
//  demo
//
//  Created by Alexander Pristavko on 3/7/19.
//  Copyright © 2019 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision

final class VisionDelegateProxy {
    weak var delegate: VisionManagerDelegate?
    let queue: DispatchQueue
    
    init(delegate: VisionManagerDelegate, queue: DispatchQueue = .main) {
        self.delegate = delegate
        self.queue = queue
    }
}

extension VisionDelegateProxy: VisionManagerDelegate {
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
    
    func visionManager(_ visionManager: VisionManager, didUpdateFrameSigns signs: FrameSigns) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateFrameSigns: signs)
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
    
    func visionManager(_ visionManager: VisionManager, didUpdateVehicleLocation vehicleLocation: VehicleLocation) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateVehicleLocation: vehicleLocation)
        }
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateCamera camera: Camera) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManager(visionManager, didUpdateCamera: camera)
        }
    }
    
    func visionManagerDidFinishUpdate(_ visionManager: VisionManager) -> Void {
        queue.async { [unowned self] in
            self.delegate?.visionManagerDidFinishUpdate(visionManager)
        }
    }
}
