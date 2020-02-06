import Foundation

class ReplaySessionManager {
    enum Constants {
        static let replaySessionFolder = "ReplaySessions"
    }
    let sessions: [ReplaySession]

    init() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(Constants.replaySessionFolder)
        do {
            let fileURLs = try fileManager.contentsOfDirectory(atPath: documentsURL.path)
            var sessions = [ReplaySession]()
            fileURLs.forEach { fileURL in
                guard let url = URL(string: fileURL) else { return }
                sessions.append(ReplaySession(name: url.lastPathComponent, path: url))
            }
            self.sessions = sessions
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
            sessions = []
        }
    }

    func delete(session: ReplaySession) {

    }
}
