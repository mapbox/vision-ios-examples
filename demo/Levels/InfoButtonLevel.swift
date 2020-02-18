import UIKit

class InfoButtonLevel: VisionStackLevel {
    private enum Constants {
        static let infoButtonPadding: CGFloat = 20
    }

    private let infoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Assets.info.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
        button.tintColor = UIColor(white: 0.5, alpha: 0.5)
        return button
    }()

    private weak var viewController: UIViewController?

    init(with visionStack: VisionStack) {
        viewController = visionStack.viewController
        super.init()
        addSubview(infoButton)
        NSLayoutConstraint.activate([
            infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.infoButtonPadding),
            infoButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.infoButtonPadding),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func infoTapped() {
        guard let viewController = viewController else { return }
        let alert: UIAlertController

        if UIDevice.current.userInterfaceIdiom == .pad {
            alert = UIAlertController(title: L10n.infoTitle, message: nil, preferredStyle: .alert)
        } else {
            alert = UIAlertController(title: L10n.infoTitle, message: nil, preferredStyle: .actionSheet)
        }

        alert.addAction(UIAlertAction(title: L10n.generalTermsOfService, style: .default) { _ in
            guard let url = URL(string: GlobalConstants.tosLink) else { return }
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: L10n.generalPrivacyPolicy, style: .default) { _ in
            guard let url = URL(string: GlobalConstants.privacyPolicyLink) else { return }
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: L10n.generalButtonCancel, style: .cancel, handler: nil))

        viewController.present(alert, animated: true)
    }
}
