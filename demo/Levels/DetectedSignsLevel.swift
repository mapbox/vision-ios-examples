import UIKit
import MapboxVision

class DetectedSignsLevel: VisionStackLevel, VisionManagerDelegate {
    private weak var visionBundle: VisionBundle?
    private enum Constants {
        static let smallRelativeInset: CGFloat = 16
        static let signTrackerMaxCapacity = 5
    }

    private let signTracker = Tracker<Sign>(maxCapacity: Constants.signTrackerMaxCapacity)
    private var signTrackerUpdateTimer: Timer?

    private let signsStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = Constants.smallRelativeInset
        view.alignment = .center
        view.axis = .horizontal
        view.isHidden = true
        return view
    }()

    init(with visionBundle: VisionBundle) {
        self.visionBundle = visionBundle
        super.init()
        addSubview(signsStack)
        NSLayoutConstraint.activate([
            signsStack.topAnchor.constraint(equalTo: topAnchor),
            signsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        scheduleSignTrackerUpdates()
        visionBundle.add(delegate: self)
    }

    deinit {
        stopSignTrackerUpdates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func visionManager(_: VisionManagerProtocol, didUpdateFrameSignClassifications frameSignClassifications: FrameSignClassifications) {
        let items = frameSignClassifications.signs.map { $0.sign }
        signTracker.update(items)
    }

    private func present(signs: [ImageAsset]) {
        signsStack.subviews.forEach { $0.removeFromSuperview() }
        signsStack.isHidden = signs.isEmpty
        signs.map { UIImageView(image: $0.image) }.forEach(signsStack.addArrangedSubview)
    }

    private func scheduleSignTrackerUpdates() {
        stopSignTrackerUpdates()

        signTrackerUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let signs = self.signTracker.getCurrent().compactMap { self.getIcon(for: $0, over: false) }
            self.present(signs: signs)
        }
    }

    private func stopSignTrackerUpdates() {
        signTrackerUpdateTimer?.invalidate()
        signTracker.reset()
    }

    private func getIcon(for sign: Sign, over: Bool) -> ImageAsset? {
        guard let visionBundle = visionBundle else { return nil }
        return sign.icon(over: over, country: visionBundle.country)
    }
}
