//
//  MockAlertPlayer.swift
//  demoTests
//
//  Created by Maksim on 11/6/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation

@testable import demo

class MockAlertPlayer: AlertPlayer {
    
    var nowPlayning: AlertSound?
    
    func play(sound: AlertSound, repeated: Bool) {
        nowPlayning = sound
    }
    
    func stop() {
        nowPlayning = nil
    }
}
