import Foundation

class ReplaySession {
    let name: String
    let path: URL

    init(name: String, path: URL) {
        self.name = name
        self.path = path
    }
}
