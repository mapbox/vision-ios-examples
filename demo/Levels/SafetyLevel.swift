import UIKit
import MapboxVisionSafety

class SafetyLevel: VisionStackLevel {
    private enum Constants {
        static let bannerInset: CGFloat = 18
        static let smallRelativeInset: CGFloat = 16
        static let buttonHeight: CGFloat = 36
        static let collisionAlertDelay: TimeInterval = 3
    }
    private let distanceView: DistanceView = {
        let view = DistanceView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()

    private let distanceLabel: PaddedLabel = {
        let view = PaddedLabel.createDarkRounded()
        return view
    }()

    private var collisionObjectViews: [CollisionObjectView] = []

    private let collisionAlertView: UIImageView = {
        let view = UIImageView(image: Asset.Assets.brake.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private let collisionBanerView: UIImageView = {
        let view = UIImageView(image: Asset.Assets.collisionBanner.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        view.contentMode = .center
        view.isHidden = true
        return view
    }()

    private lazy var distanceFormatter: DistanceFormatter = {
        DistanceFormatter(approximate: false)
    }()
    private let alertPlayer: AlertPlayer = AlertSoundPlayer()
    private var collisionAlertRestriction = AutoResetRestriction(resetInterval: Constants.collisionAlertDelay)

    init(with safetyBundle: VisionSafetyBundle) {
        super.init()
        set(transparency: 0.0)
        addSubview(distanceView)

        addSubview(distanceLabel)
        NSLayoutConstraint.activate([
            distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.smallRelativeInset),
            distanceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
        ])

        addSubview(collisionAlertView)
        NSLayoutConstraint.activate([
            collisionAlertView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.bannerInset),
            collisionAlertView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])

        addSubview(collisionBanerView)
        NSLayoutConstraint.activate([
            collisionBanerView.topAnchor.constraint(equalTo: topAnchor),
            collisionBanerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collisionBanerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collisionBanerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        safetyBundle.add(delegate: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func present(distance: Double, objectFrame frame: CGRect, canvasSize: CGSize) {
        distanceView.isHidden = false
        distanceLabel.isHidden = false

        let left = CGPoint(x: frame.minX, y: frame.maxY).convertForAspectRatioFill(from: canvasSize, to: bounds.size)
        let right = CGPoint(x: frame.maxX, y: frame.maxY).convertForAspectRatioFill(from: canvasSize, to: bounds.size)

        distanceView.update(left, right)
        distanceLabel.text = distanceFormatter.string(fromMeters: distance)
    }

    private func present(collisions: [SafetyState.Collision]) {
        collisionObjectViews.forEach { $0.removeFromSuperview() }
        collisionObjectViews.removeAll()

        for collision in collisions {
            var collisionObjectView: CollisionObjectView?

            switch (collision.state, collision.objectType) {
            case (.warning, .car):
                collisionObjectView = createCollisionObjectView(frame: collision.boundingBox, canvasSize: collision.imageSize.cgSize)
                collisionAlertView.isHidden = false
            case (.warning, .person):
                collisionObjectView = createCollisionObjectView(frame: collision.boundingBox, canvasSize: collision.imageSize.cgSize)
                collisionObjectView?.exclamationMarkView.isHidden = true
            case (.critical, .car):
                collisionBanerView.isHidden = false
                return
            case (.critical, .person):
                collisionObjectView = createCollisionObjectView(frame: collision.boundingBox, canvasSize: collision.imageSize.cgSize)
                collisionAlertView.isHidden = false
            }

            collisionObjectView?.color = collision.objectType.color

            if let collisionObjectView = collisionObjectView {
                collisionObjectViews.append(collisionObjectView)
                addSubview(collisionObjectView)
            }
        }
    }

    private func createCollisionObjectView(frame: CGRect, canvasSize: CGSize) -> CollisionObjectView {
        let leftTop = frame.origin.convertForAspectRatioFill(from: canvasSize, to: bounds.size)
        let rightBottom = CGPoint(x: frame.maxX, y: frame.maxY).convertForAspectRatioFill(from: canvasSize, to: bounds.size)

        let rect = CGRect(x: leftTop.x, y: leftTop.y, width: rightBottom.x - leftTop.x, height: rightBottom.y - leftTop.y)
        let coef: CGFloat = 0.25
        let extendedRect = rect.insetBy(dx: -(rect.width * coef), dy: -(rect.height * coef))

        return CollisionObjectView(frame: extendedRect)
    }

    func present(safetyState: SafetyState) {

        switch safetyState {
        case .none:
            break
        case let .collisions(collisions):
            present(collisions: collisions)
        }
    }
}

extension SafetyLevel: VisionSafetyManagerDelegate {
    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateCollisions collisions: [CollisionObject]) {
        let state = SafetyState(collisions)

        switch state {
        case .none: break
        case .collisions(let collisions):
            let containsPerson = collisions.contains { $0.objectType == .person && $0.state == .critical }
            if containsPerson, collisionAlertRestriction.isAllowed {
                alertPlayer.play(sound: .collisionAlertCritical, repeated: false)
                collisionAlertRestriction.restrict()
            }
        }

        present(safetyState: state)
    }
}

private extension SafetyState.ObjectType {
    var color: UIColor {
        switch self {
        case .car:
            return UIColor(red: 1.0, green: 0, blue: 55 / 255.0, alpha: 1.0)
        case .person:
            return UIColor(red: 239.0 / 255.0, green: 6.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        }
    }
}

private class AutoResetRestriction {
    var isAllowed: Bool = true

    private let resetInterval: TimeInterval

    private var timer: Timer?

    init(resetInterval: TimeInterval) {
        self.resetInterval = resetInterval
    }

    func restrict() {
        isAllowed = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: resetInterval, repeats: false) { [weak self] _ in
            self?.isAllowed = true
        }
    }
}
