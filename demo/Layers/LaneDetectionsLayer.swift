import MapboxVision
import UIKit

class LaneDetectionsLayer: VisionStackLayer {
    private enum Constants {
        static let bannerInset: CGFloat = 18
        static let roadLanesHeight: CGFloat = 64
    }

    private let roadLanesView: RoadLanesView = {
        let view = RoadLanesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    init(with visionBundle: VisionBundle) {
        super.init()

        addSubview(roadLanesView)
        NSLayoutConstraint.activate([
            roadLanesView.centerXAnchor.constraint(equalTo: centerXAnchor),
            roadLanesView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.bannerInset),
            roadLanesView.heightAnchor.constraint(equalToConstant: Constants.roadLanesHeight),
        ])

        visionBundle.add(delegate: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func present(roadDescription: RoadDescription?) {
        DispatchQueue.main.async {
            guard let roadDescription = roadDescription else {
                self.roadLanesView.isHidden = true
                return
            }
            self.roadLanesView.isHidden = false
            self.roadLanesView.update(roadDescription)
        }
    }
}

extension LaneDetectionsLayer: VisionManagerDelegate {
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateRoadDescription roadDescription: RoadDescription) {
        present(roadDescription: roadDescription)
    }
}
