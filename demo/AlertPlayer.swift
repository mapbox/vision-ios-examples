import Foundation
import AVFoundation

private let defaultSound: SystemSoundID = 1002

enum AlertSound {
    case collisionAlertWarning
    case collisionAlertCritical
    case overSpeedLimit

    static let type = "wav"

    fileprivate var path: String {
        switch self {
        case .collisionAlertWarning:
            return "collision_alert_critical"
        case .collisionAlertCritical:
            return "collision_alert_warning"
        case .overSpeedLimit:
            return "overspeed_warning"
        }
    }

    fileprivate var url: URL? {
        guard let url = Bundle.main.url(forResource: path, withExtension: AlertSound.type) else {
            assertionFailure("Alert for name \(path).\(AlertSound.type) is not found")
            return nil
        }
        return url
    }
}

protocol AlertPlayer {
    func play(sound: AlertSound, repeated: Bool)
    func stop()
}

final class AlertSoundPlayer: AlertPlayer {

    private struct Item: Equatable, CustomStringConvertible {
        let sound: AlertSound
        let repeated: Bool

        var description: String {
            return "Item(sound: \(sound), repeated: \(repeated))"
        }
    }

    private enum State {
        case idle
        case playing(item: Item)
        case stopped(item: Item)
    }

    private var state: State = .idle
    private var pendingItem: Item?
    private let soundSource = SoundSource()

    func play(sound: AlertSound, repeated: Bool = false) {
        let newItem = Item(sound: sound, repeated: repeated)

        switch state {
        case .playing(let item) where item == newItem:
            return
        case .playing:
            stopPlayingCurrent()
            fallthrough
        case .stopped:
            pendingItem = newItem
        case .idle:
            startPlaying(newItem)
        }
    }

    func stop() {
        pendingItem = nil
        stopPlayingCurrent()
    }

    private func startPlaying(_ item: Item) {
        pendingItem = nil
        state = .playing(item: item)
        soundSource.play(item.sound, completion: completion)
    }

    private func stopPlayingCurrent() {
        guard case let .playing(item) = state else { return }
        state = .stopped(item: item)
        soundSource.dispose(item.sound)
    }

    private func completion() {
        var itemToPlay: Item?
        var itemToDispose: Item?

        switch state {
        case .playing(let item) where item.repeated:
            itemToPlay = item
        case .playing(let item):
            itemToDispose = item
        case .stopped, .idle: break
        }

        if let item = itemToDispose {
            soundSource.dispose(item.sound)
        }

        if let item = pendingItem ?? itemToPlay {
            startPlaying(item)
        } else {
            state = .idle
        }
    }
}

private class SoundSource {
    private var cache: [AlertSound: SystemSoundID] = [:]

    func play(_ sound: AlertSound, completion: (() -> Void)?) {
        let id = obtainID(for: sound)
        AudioServicesPlaySystemSoundWithCompletion(id, completion)
    }

    func dispose(_ sound: AlertSound) {
        guard let id = cache.removeValue(forKey: sound) else { return }
        AudioServicesDisposeSystemSoundID(id)
    }

    private func obtainID(for sound: AlertSound) -> SystemSoundID {
        if let id = cache[sound] {
            return id
        } else {
            let id = createID(for: sound)
            cache[sound] = id
            return id
        }
    }

    private func createID(for sound: AlertSound) -> SystemSoundID {
        var soundID: SystemSoundID = 0
        if let url = sound.url {
            AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        } else {
            soundID = defaultSound
        }
        return soundID
    }
}
