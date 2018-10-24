//
//  VideoStreamInteractor.swift
//  cv-assist-ios
//
//  Created by Alexander Pristavko on 4/2/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import AVFoundation

private let defaultSound: SystemSoundID = 1002

enum AlertSound {
    case collisionAlertWarning
    case collisionAlertCritical
    case laneDepartureWarning
    
    static let type = "wav"
    
    private var path: String {
        switch self {
        case .collisionAlertWarning:
            return "collision_alert_critical"
        case .collisionAlertCritical:
            return "collision_alert_warning"
        case .laneDepartureWarning:
            return "lane_departure_warning"
        }
    }
    
    private var url: URL? {
        guard let url = Bundle.main.url(forResource: path, withExtension: AlertSound.type) else {
            assertionFailure("Alert for name \(path).\(AlertSound.type) is not found")
            return nil
        }
        return url
    }
    
    var soundID: SystemSoundID? {
        var soundID: SystemSoundID = 0
        if let url = url {
            AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        } else {
            soundID = defaultSound
        }
        return soundID
    }
}

final class AlertPlayer {
    private enum State {
        case idle
        case playing(repeated: Bool, soundID: SystemSoundID)
        case stopped(soundID: SystemSoundID)
    }
    
    private var state: State = .idle
    
    func play(sound: AlertSound, repeated: Bool = false) {
        switch state {
        case .playing: return
        case .idle, .stopped: break
        }
        
        guard let soundID = sound.soundID else { return }
        
        state = .playing(repeated: repeated, soundID: soundID)
        
        startPlaying(soundID: soundID)
    }
    
    func stop() {
        guard case let .playing(_, soundID) = state else { return }
        state = .stopped(soundID: soundID)
    }
    
    private func startPlaying(soundID: SystemSoundID) {
        AudioServicesPlaySystemSoundWithCompletion(soundID, completion)
    }
    
    private func completion() {
        let soundIDToDelete: SystemSoundID
        
        switch state {
        case let .playing(repeated, soundID) where repeated:
            startPlaying(soundID: soundID)
            return
        case let .playing(repeated, soundID) where !repeated:
            fallthrough
        case let .stopped(soundID):
            soundIDToDelete = soundID
        default: return
        }
        
        AudioServicesDisposeSystemSoundID(soundIDToDelete)
        state = .idle
    }
}
