//
// Created by Alexander Pristavko on 7/10/18.
// Copyright (c) 2018 Mapbox. All rights reserved.
//

import Foundation
import VisionCore

protocol BroadcastingDelegate: class {
    func startReceived(timestamp: String)
}

private let port = 5097
private let serverIPKey = "serverIPSetting"

final class BroadcastService {
    
    weak var delegate: BroadcastingDelegate?
    
    private var broadcasting: Broadcasting?
    private let broadcastingQueue = DispatchQueue(label: "com.mapbox.Broadcasting")
    
    var ipAddress: String? {
        get {
            return UserDefaults.standard.string(forKey: serverIPKey)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: serverIPKey)
        }
    }
    
    @discardableResult
    func start() -> Bool {
        guard let savedIPAddress = ipAddress else {
            return false
        }
        
        broadcasting?.stop()
        
        let newBroadcasting = Broadcasting(ip: savedIPAddress, port: Int32(port))
        if let delegate = delegate {
            newBroadcasting.setDidReceiveStarted(delegate.startReceived)
        }
        
        broadcasting = newBroadcasting
        broadcastingQueue.async(execute: broadcasting!.start)
        
        return true
    }
    
    func stop() {
        broadcasting?.stop()
    }
}
