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
