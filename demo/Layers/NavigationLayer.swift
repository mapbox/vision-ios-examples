import MapboxCoreNavigation
import MapboxDirections
import UIKit

class NavigationLayer: VisionStackLayer {
    private enum Constants {
        static let inset: CGFloat = 18.0
    }

    private var navigationService: NavigationService?

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

    init(with route: Route) {
        super.init()
        addSubview(instructionsLabel)
        NSLayoutConstraint.activate([
            instructionsLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            instructionsLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.inset),
            instructionsLabel.heightAnchor.constraint(equalToConstant: 44),
        ])

        navigationService = MapboxNavigationService(route: route)
        navigationService?.delegate = self
        navigationService?.start()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NavigationLayer: NavigationServiceDelegate {
    func navigationService(_ service: NavigationService, didUpdate progress: RouteProgress, with location: CLLocation, rawLocation: CLLocation) {
        instructionsLabel.isHidden = false
        instructionsLabel.text = progress.currentLegProgress.currentStep.instructions
    }
}
