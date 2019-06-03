import CoreMedia
import MapboxNavigation
import MapboxVision
import MapboxVisionAR
import UIKit

private let bannerInset: CGFloat = 18
private let roadLanesHeight: CGFloat = 64
private let smallRelativeInset: CGFloat = 16
private let buttonHeight: CGFloat = 36

final class ContainerViewController: UIViewController {
    weak var delegate: ContainerDelegate? {
        willSet {
            backButton.removeTarget(delegate, action: #selector(ContainerDelegate.backButtonPressed), for: .touchUpInside)
        }
        didSet {
            backButton.addTarget(delegate, action: #selector(ContainerDelegate.backButtonPressed), for: .touchUpInside)
        }
    }

    var visionViewController: VisionPresentationViewController?
    var menuViewController: MenuViewController?
    private lazy var arContainerViewController = ARContainerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        arContainerViewController.navigationDelegate = self

        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            backButton.widthAnchor.constraint(lessThanOrEqualToConstant: 44),
            backButton.heightAnchor.constraint(lessThanOrEqualToConstant: 44)
        ])

        view.addSubview(roadLanesView)
        NSLayoutConstraint.activate([
            roadLanesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roadLanesView.topAnchor.constraint(equalTo: view.topAnchor, constant: bannerInset),
            roadLanesView.heightAnchor.constraint(equalToConstant: roadLanesHeight)
        ])

        view.addSubview(signsStack)
        NSLayoutConstraint.activate([
            signsStack.topAnchor.constraint(equalTo: view.topAnchor),
            signsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        view.addSubview(distanceView)

        view.addSubview(distanceLabel)
        NSLayoutConstraint.activate([
            distanceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -smallRelativeInset),
            distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])

        view.addSubview(collisionAlertView)
        NSLayoutConstraint.activate([
            collisionAlertView.topAnchor.constraint(equalTo: view.topAnchor, constant: bannerInset),
            collisionAlertView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(collisionBanerView)
        NSLayoutConstraint.activate([
            collisionBanerView.topAnchor.constraint(equalTo: view.topAnchor),
            collisionBanerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collisionBanerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collisionBanerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        view.addSubview(calibrationLabel)
        NSLayoutConstraint.activate([
            calibrationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: bannerInset),
            calibrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        view.addSubview(speedLimitView)
        NSLayoutConstraint.activate([
            speedLimitView.topAnchor.constraint(equalTo: view.topAnchor, constant: bannerInset),
            speedLimitView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -bannerInset),
        ])
    }

    override func present(viewController: UIViewController) {
        super.present(viewController: viewController)
        view.insertSubview(viewController.view, belowSubview: backButton)
    }

    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Asset.Assets.back.image, for: .normal)
        return button
    }()

    private let roadLanesView: RoadLanesView = {
        let view = RoadLanesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    private let signsStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = smallRelativeInset
        view.alignment = .center
        view.axis = .horizontal
        view.isHidden = true
        return view
    }()

    private let distanceView: DistanceView = {
        let view = DistanceView(frame: .zero)
        view.backgroundColor = .clear
        view.isHidden = true
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

    private let calibrationLabel: UILabel = {
        let label = PaddedLabel.createDarkRounded()
        return label
    }()

    private let speedLimitView: ImageSwitchingView = {
        let view = ImageSwitchingView()
        view.spacing = bannerInset
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var distanceFormatter: DistanceFormatter = {
        return DistanceFormatter(approximate: false)
    }()

    private weak var currentViewController: UIViewController?
}

extension ContainerViewController: ContainerPresenter {
    private func dismissSafetyStateViews() {
        distanceView.isHidden = true
        distanceLabel.isHidden = true

        collisionAlertView.isHidden = true
        collisionBanerView.isHidden = true

        collisionObjectViews.forEach { $0.removeFromSuperview() }
        collisionObjectViews.removeAll()
    }

    private func present(distance: Double, objectFrame frame: CGRect, canvasSize: CGSize) {
        distanceView.isHidden = false
        distanceLabel.isHidden = false

        let left = CGPoint(x: frame.minX, y: frame.maxY).convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)
        let right = CGPoint(x: frame.maxX, y: frame.maxY).convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)

        distanceView.update(left, right)
        distanceLabel.text = distanceFormatter.string(fromMeters: distance)
    }

    private func present(collisions: [SafetyState.Collision]) {
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
            case (.critical ,.person):
                collisionObjectView = createCollisionObjectView(frame: collision.boundingBox, canvasSize: collision.imageSize.cgSize)
                collisionAlertView.isHidden = false
            }

            collisionObjectView?.color = collision.objectType.color

            if let collisionObjectView = collisionObjectView {
                collisionObjectViews.append(collisionObjectView)
                view.addSubview(collisionObjectView)
            }
        }
    }

    private func createCollisionObjectView(frame: CGRect, canvasSize: CGSize) -> CollisionObjectView {
        let leftTop = frame.origin.convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)
        let rightBottom = CGPoint(x: frame.maxX, y: frame.maxY).convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)

        let rect = CGRect(x: leftTop.x, y: leftTop.y, width: rightBottom.x - leftTop.x, height: rightBottom.y - leftTop.y)
        let coef: CGFloat = 0.25
        let extendedRect = rect.insetBy(dx: -(rect.width * coef), dy: -(rect.height * coef))

        return CollisionObjectView(frame: extendedRect)
    }

    func present(safetyState: SafetyState) {
        dismissSafetyStateViews()

        switch safetyState {
        case .none:
            break
        case let .collisions(collisions):
            present(collisions: collisions)
        }
    }

    func present(frame: CMSampleBuffer) {
        if currentViewController == arContainerViewController {
            arContainerViewController.present(sampleBuffer: frame)
        } else {
            visionViewController?.present(sampleBuffer: frame)
        }
    }

    func present(segmentation: FrameSegmentation) {
        visionViewController?.present(segmentation: segmentation)
    }

    func present(detections: FrameDetections) {
        visionViewController?.present(detections: detections)
    }

    func present(signs: [ImageAsset]) {
        signsStack.subviews.forEach { $0.removeFromSuperview() }
        signsStack.isHidden = signs.isEmpty
        signs.map { UIImageView(image: $0.image) }.forEach(signsStack.addArrangedSubview)
    }

    func present(roadDescription: RoadDescription?) {
        DispatchQueue.main.async {
            guard let roadDescription = roadDescription else {
                self.roadLanesView.isHidden = true
                return
            }
            self.roadLanesView.isHidden = false
            self.roadLanesView.update(roadDescription)
        }
    }

    func present(calibrationProgress: CalibrationProgress?) {
        calibrationLabel.isHidden = calibrationProgress?.isCalibrated ?? true
        guard let calibrationProgress = calibrationProgress else { return }
        calibrationLabel.text = L10n.generalCalibration(Int(ceil(calibrationProgress.calibrationProgress * 100)))
    }

    func present(speedLimit: ImageAsset?, isNew: Bool) {
        guard let speedLimit = speedLimit else {
            speedLimitView.reset()
            speedLimitView.isHidden = true
            return
        }

        speedLimitView.isHidden = false
        if isNew {
            speedLimitView.switch(to: speedLimit.image)
        } else {
            speedLimitView.image = speedLimit.image
        }
    }

    func present(camera: ARCamera) {
        arContainerViewController.present(camera: camera)
    }

    func present(lane: ARLane?) {
        arContainerViewController.present(lane: lane)
    }

    func present(screen: Screen) {
        switch screen {
        case .signsDetection: visionViewController?.frameVisualizationMode = .clear
        case .segmentation: visionViewController?.frameVisualizationMode = .segmentation
        case .objectDetection: visionViewController?.frameVisualizationMode = .detection
        case .distanceToObject: visionViewController?.frameVisualizationMode = .clear
        case .map: presentMap()
        case .laneDetection: visionViewController?.frameVisualizationMode = .clear
        case .arRouting: presentARRouting()
        case .menu: presentMenu()
        }
    }

    func presentMenu() {
        guard let viewController = menuViewController else {
            assertionFailure("Menu should be initialized before presenting")
            return
        }
        present(viewController: viewController)
        visionViewController?.frameVisualizationMode = .clear
        currentViewController = menuViewController
    }

    func presentVision() {
        guard let viewController = visionViewController else {
            assertionFailure("Vision should be initialized before presenting")
            return
        }

        present(viewController: viewController)
        viewController.frameVisualizationMode = .clear
    }

    private func presentMap() {
        let viewController = MapViewController()
        present(viewController: viewController)
        currentViewController = viewController
    }

    private func presentARRouting() {
        visionViewController?.view.isHidden = true
        present(viewController: arContainerViewController)
        currentViewController = arContainerViewController
    }

    func presentBackButton(isVisible: Bool) {
        backButton.isHidden = !isVisible
    }

    func dismissCurrent() {
        guard let viewController = currentViewController else { return }
        if currentViewController == arContainerViewController {
            visionViewController?.view.isHidden = false
        }
        dismiss(viewController: viewController)
        currentViewController = nil
    }
}

extension UIViewController {
    @objc
    func present(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        viewController.didMove(toParent: self)
    }

    func dismiss(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

private extension SafetyState.ObjectType {
    var color: UIColor {
        switch self {
        case .car:
            return UIColor(red: 1.0, green: 0, blue: 55/255.0, alpha: 1.0)
        case .person:
            return UIColor(red: 239.0/255.0, green: 6.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
    }
}

extension ContainerViewController: NavigationDelegate {
    
    func navigation(didUpdate route: MapboxVisionAR.Route) {
        delegate?.didNavigationRouteUpdated(route: route)
    }
    
    func navigationDidArriveAtDestination() {
        delegate?.didNavigationRouteUpdated(route: nil)
    }
}
