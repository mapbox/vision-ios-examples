import CoreMedia
import MapboxCoreNavigation
import MapboxDirections
import MapboxVisionAR
import UIKit

private let inset: CGFloat = 18.0

private enum ARFeature {
    case lane
    case fence
    case laneAndFence

    var next: ARFeature {
        switch self {
        case .lane:
            return .fence
        case .fence:
            return .laneAndFence
        case .laneAndFence:
            return .lane
        }
    }

    var containsLane: Bool {
        return self == .lane || self == .laneAndFence
    }

    var containsFence: Bool {
        return self == .fence || self == .laneAndFence
    }
}

final class ARContainerViewController: UIViewController {
    private lazy var mapViewController = ARMapNavigationController()
    private lazy var arViewController = VisionARViewController()

    weak var navigationDelegate: NavigationDelegate?
    private var navigationService: NavigationService?
    private var activeARFeature: ARFeature = .lane {
        didSet {
//            arViewController.la
//            arViewController.isLaneVisible = activeARFeature.containsLane
//            arViewController.isFenceVisible = activeARFeature.containsFence
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewController.completion = present

        presentMap()

        let featureSwitchButton = UIButton()
        featureSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        featureSwitchButton.setTitle("", for: .normal)
        arViewController.view.addSubview(featureSwitchButton)
        featureSwitchButton.addTarget(self, action: #selector(switchARFeature), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            featureSwitchButton.centerXAnchor.constraint(equalTo: arViewController.view.centerXAnchor),
            featureSwitchButton.centerYAnchor.constraint(equalTo: arViewController.view.centerYAnchor),
            featureSwitchButton.heightAnchor.constraint(equalTo: arViewController.view.heightAnchor),
            featureSwitchButton.widthAnchor.constraint(equalTo: arViewController.view.widthAnchor),
        ])

        arViewController.view.addSubview(endButton)
        NSLayoutConstraint.activate([
            endButton.trailingAnchor.constraint(equalTo: arViewController.view.trailingAnchor, constant: -inset),
            endButton.topAnchor.constraint(equalTo: arViewController.view.safeAreaLayoutGuide.topAnchor, constant: inset),
            endButton.heightAnchor.constraint(equalToConstant: 44),
            endButton.widthAnchor.constraint(equalToConstant: 90),
        ])

        arViewController.view.addSubview(instructionsLabel)
        NSLayoutConstraint.activate([
            instructionsLabel.centerXAnchor.constraint(equalTo: arViewController.view.safeAreaLayoutGuide.centerXAnchor),
            instructionsLabel.topAnchor.constraint(equalTo: arViewController.view.safeAreaLayoutGuide.topAnchor, constant: inset),
            instructionsLabel.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    @objc
    func switchARFeature() {
        activeARFeature = activeARFeature.next
    }

    @objc
    func presentMap() {
        dismiss(viewController: arViewController)
        present(viewController: mapViewController)
    }

    func present(route: MapboxDirections.Route) {
        dismiss(viewController: mapViewController)

        navigationService = MapboxNavigationService(route: route)
        navigationService?.delegate = self
        navigationDelegate?.navigation(didUpdate: Route(route: route))
        present(viewController: arViewController)
        navigationService?.start()
    }

    func inject(arManager: VisionARManager) {
        arViewController.set(arManager: arManager)
    }

    private let instructionsLabel: UILabel = {
        let label = PaddedLabel(insets: UIEdgeInsets(top: 10, left: 18, bottom: 10, right: 18))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0, alpha: 0.85)
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.layer.cornerRadius = 22
        label.isHidden = true
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()

    private let endButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("End", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.red, for: .normal)
        button.setBackgroundColor(UIColor(white: 0, alpha: 0.85), for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(presentMap), for: .touchUpInside)
        return button
    }()
}

extension ARContainerViewController: NavigationServiceDelegate {
    func navigationService(_ service: NavigationService, didUpdate progress: RouteProgress, with location: CLLocation, rawLocation: CLLocation) {
        instructionsLabel.isHidden = false
        instructionsLabel.text = progress.currentLegProgress.currentStep.instructions
    }

    func navigationService(_ service: NavigationService, didArriveAt waypoint: Waypoint) -> Bool {
        if service.routeProgress.isFinalLeg, service.routeProgress.currentLeg.destination == waypoint {
            navigationDelegate?.navigationDidArriveAtDestination()
        }
        return true
    }

    func navigationService(_ service: NavigationService, didRerouteAlong route: MapboxDirections.Route, at location: CLLocation?, proactive: Bool) {
        navigationDelegate?.navigation(didUpdate: Route(route: route))
    }
}

public protocol NavigationDelegate: AnyObject {
    func navigation(didUpdate route: MapboxVisionARNative.Route)
    func navigationDidArriveAtDestination()
}
