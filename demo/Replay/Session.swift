import Foundation

class ReplaySession {
    let name: String
    let path: URL
    let creationDate: Date?

    init(name: String, path: URL) {
        self.name = name
        self.path = path
        let attrs = try? FileManager.default.attributesOfItem(atPath: path.path) as NSDictionary
        creationDate = attrs?.fileCreationDate()
    }
}
