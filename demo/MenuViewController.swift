import UIKit

final class MenuViewController: UIViewController {
    private static let buttonPadding: CGFloat = 14.0
    private static let cellHeight: CGFloat = 147.0
    private static let cellWidth: CGFloat = 180.0
    private static let infoButtonPadding: CGFloat = 20

    // MARK: Properties

    weak var delegate: MenuDelegate?

    // MARK: Private properties

    private let infoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Assets.info.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
        button.tintColor = UIColor(white: 0.5, alpha: 0.5)
        return button
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)

        let select: (Screen) -> Void = { [weak self] screen in
            self?.delegate?.selected(screen: screen)
        }

        let segmentationButton = MenuItemButton(for: .segmentation, action: select)
        let laneDetectionButton = MenuItemButton(for: .laneDetection, action: select)
        let distanceToObjectButton = MenuItemButton(for: .distanceToObject, action: select)
        let signsDetectionButton = MenuItemButton(for: .signsDetection, action: select)
        let objectDetectorButton = MenuItemButton(for: .objectDetection, action: select)
        let objectMappingButton = MenuItemButton(for: .map, action: select)
        let arRoutingButton = MenuItemButton(for: .arRouting, action: select)

        let titleView = UIImageView(image: Asset.Assets.title.image)
        addToView(titleImageView: titleView)

        let lineCenterImage = Asset.Assets.lineCenter.image
        let centerLine = UIImageView(image: lineCenterImage)
        addToView(centerLineImageView: centerLine)

        let lineLeftRightImage = Asset.Assets.lineLeftRight.image
        let leftLine = UIImageView(image: lineLeftRightImage)
        addToView(leftLineImageView: leftLine, withDependencyOn: centerLine)

        let rightLine = UIImageView(image: lineLeftRightImage)
        addToView(rightLineImageView: rightLine, withDependencyOn: centerLine)

        let lineTopBottomImage = Asset.Assets.lineTopBottom.image
        let topFirstLine = UIImageView(image: lineTopBottomImage)
        addToView(topFirstLineImageView: topFirstLine, withDependencyOn: centerLine)

        let topSecondLine = UIImageView(image: lineTopBottomImage)
        addToView(topSecondLineImageView: topSecondLine, withDependencyOn: centerLine)

        let topThirdLine = UIImageView(image: lineTopBottomImage)
        addToView(topThirdLineImageView: topThirdLine, withDependencyOn: centerLine)

        addToView(signsDetectionButton: signsDetectionButton, withDependencyOn: centerLine, withDependencyOn: leftLine)
        addToView(segmentationButton: segmentationButton, withDependencyOn: centerLine, withDependencyOn: topFirstLine)
        addToView(objectDetectorButton: objectDetectorButton, withDependencyOn: centerLine, withDependencyOn: topSecondLine)
        addToView(arRoutingButton: arRoutingButton, withDependencyOn: centerLine, withDependencyOn: leftLine)

        let bottomFirstLine = UIImageView(image: lineTopBottomImage)
        addToView(bottomFirstLine: bottomFirstLine, withDependencyOn: centerLine, withDependencyOn: arRoutingButton)

        let bottomSecondLine = UIImageView(image: lineTopBottomImage)
        addToView(bottomSecondLine: bottomSecondLine, withDependencyOn: centerLine, withDependencyOn: arRoutingButton)

        addToView(distanceToObjectButton: distanceToObjectButton,
                  withDependencyOn: centerLine,
                  withDependencyOn: bottomFirstLine,
                  withDependencyOn: leftLine)

        addToView(objectMappingButton: objectMappingButton, withDependencyOn: centerLine, withDependencyOn: topThirdLine)

        addToView(laneDetectionButton: laneDetectionButton,
                  withDependencyOn: centerLine,
                  withDependencyOn: bottomSecondLine,
                  withDependencyOn: leftLine)

        addToViewInfoButton()
    }

    // MARK: Private functions

    private func addToView(titleImageView: UIImageView) {
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleImageView)
        NSLayoutConstraint.activate([
            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),
        ])
    }

    private func addToView(centerLineImageView: UIImageView) {
        centerLineImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerLineImageView)
        NSLayoutConstraint.activate([
            centerLineImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            centerLineImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 18),
            centerLineImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
        ])
    }

    private func addToView(leftLineImageView: UIImageView, withDependencyOn centerLine: UIImageView) {
        leftLineImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftLineImageView)
        NSLayoutConstraint.activate([
            leftLineImageView.centerYAnchor.constraint(equalTo: centerLine.centerYAnchor),
            leftLineImageView.trailingAnchor.constraint(equalTo: centerLine.leadingAnchor),
            leftLineImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
        ])
    }

    private func addToView(rightLineImageView: UIImageView, withDependencyOn centerLine: UIImageView) {
        rightLineImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        rightLineImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightLineImageView)
        NSLayoutConstraint.activate([
            rightLineImageView.centerYAnchor.constraint(equalTo: centerLine.centerYAnchor),
            rightLineImageView.leadingAnchor.constraint(equalTo: centerLine.trailingAnchor),
            rightLineImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
        ])
    }

    private func addToView(topFirstLineImageView: UIImageView, withDependencyOn centerLine: UIImageView) {
        topFirstLineImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topFirstLineImageView)
        NSLayoutConstraint.activate([
            topFirstLineImageView.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            topFirstLineImageView.leadingAnchor.constraint(equalTo: centerLine.leadingAnchor),
        ])
    }

    private func addToView(topSecondLineImageView: UIImageView, withDependencyOn centerLine: UIImageView) {
        topSecondLineImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topSecondLineImageView)
        NSLayoutConstraint.activate([
            topSecondLineImageView.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            topSecondLineImageView.trailingAnchor.constraint(equalTo: centerLine.centerXAnchor),
        ])
    }

    private func addToView(topThirdLineImageView: UIImageView, withDependencyOn centerLine: UIImageView) {
        topThirdLineImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topThirdLineImageView)
        NSLayoutConstraint.activate([
            topThirdLineImageView.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            topThirdLineImageView.trailingAnchor.constraint(equalTo: centerLine.trailingAnchor),
        ])
    }

    private func addToView(
        signsDetectionButton: MenuItemButton,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn leftLine: UIImageView
    ) {
        view.addSubview(signsDetectionButton)
        NSLayoutConstraint.activate([
            signsDetectionButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            signsDetectionButton.trailingAnchor.constraint(equalTo: centerLine.leadingAnchor),
            signsDetectionButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            signsDetectionButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight),
        ])
    }

    private func addToView(
        segmentationButton: MenuItemButton,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn topFirstLine: UIImageView
    ) {
        view.addSubview(segmentationButton)
        NSLayoutConstraint.activate([
            segmentationButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            segmentationButton.leadingAnchor.constraint(equalTo: topFirstLine.leadingAnchor),
            segmentationButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            segmentationButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight),
        ])
    }

    private func addToView(
        objectDetectorButton: MenuItemButton,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn topSecondLine: UIImageView
    ) {
        view.addSubview(objectDetectorButton)
        NSLayoutConstraint.activate([
            objectDetectorButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            objectDetectorButton.leadingAnchor.constraint(equalTo: topSecondLine.leadingAnchor),
            objectDetectorButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            objectDetectorButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight),
        ])
    }

    private func addToView(
        arRoutingButton: MenuItemButton,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn leftLine: UIImageView
    ) {
        view.addSubview(arRoutingButton)
        NSLayoutConstraint.activate([
            arRoutingButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            arRoutingButton.centerXAnchor.constraint(equalTo: centerLine.centerXAnchor),
            arRoutingButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            arRoutingButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight),
        ])
    }

    private func addToView(
        bottomFirstLine: UIImageView,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn arRoutingButton: MenuItemButton
    ) {
        bottomFirstLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        bottomFirstLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomFirstLine)
        NSLayoutConstraint.activate([
            bottomFirstLine.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            bottomFirstLine.leadingAnchor.constraint(equalTo: arRoutingButton.leadingAnchor),
        ])
    }

    private func addToView(
        bottomSecondLine: UIImageView,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn arRoutingButton: MenuItemButton
    ) {
        bottomSecondLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        bottomSecondLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSecondLine)
        NSLayoutConstraint.activate([
            bottomSecondLine.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            bottomSecondLine.trailingAnchor.constraint(equalTo: arRoutingButton.trailingAnchor),
        ])
    }

    private func addToView(
        distanceToObjectButton: MenuItemButton,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn bottomFirstLine: UIImageView,
        withDependencyOn leftLine: UIImageView
    ) {
        view.addSubview(distanceToObjectButton)
        NSLayoutConstraint.activate([
            distanceToObjectButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            distanceToObjectButton.trailingAnchor.constraint(equalTo: bottomFirstLine.leadingAnchor),
            distanceToObjectButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            distanceToObjectButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight),
        ])
    }

    private func addToView(
        objectMappingButton: MenuItemButton,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn topThirdLine: UIImageView
    ) {
        view.addSubview(objectMappingButton)
        NSLayoutConstraint.activate([
            objectMappingButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            objectMappingButton.leadingAnchor.constraint(equalTo: topThirdLine.leadingAnchor),
            objectMappingButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            objectMappingButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight),
        ])
    }

    private func addToView(
        laneDetectionButton: MenuItemButton,
        withDependencyOn centerLine: UIImageView,
        withDependencyOn bottomSecondLine: UIImageView,
        withDependencyOn leftLine: UIImageView
    ) {
        view.addSubview(laneDetectionButton)
        NSLayoutConstraint.activate([
            laneDetectionButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            laneDetectionButton.leadingAnchor.constraint(equalTo: bottomSecondLine.leadingAnchor),
            laneDetectionButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            laneDetectionButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight),
        ])
    }

    private func addToViewInfoButton() {
        view.addSubview(infoButton)
        NSLayoutConstraint.activate([
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MenuViewController.infoButtonPadding),
            infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: MenuViewController.infoButtonPadding),
        ])
    }

    @objc
    private func infoTapped() {
        let alert = UIAlertController(title: L10n.infoTitle, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: L10n.generalTermsOfService, style: .default) { _ in
            guard let url = URL(string: GlobalConstants.tosLink) else { return }
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: L10n.generalPrivacyPolicy, style: .default) { _ in
            guard let url = URL(string: GlobalConstants.privacyPolicyLink) else { return }
            UIApplication.shared.open(url)
        })
        alert.addAction(UIAlertAction(title: L10n.generalButtonCancel, style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}

extension Screen {
    var title: String {
        switch self {
        case .segmentation:
            return L10n.menuSegmentationButton
        case .laneDetection:
            return L10n.menuLaneDetectionButton
        case .distanceToObject:
            return L10n.menuCollisionDetectionButton
        case .signsDetection:
            return L10n.menuSignDetectionButton
        case .objectDetection:
            return L10n.menuObjectDetectionButton
        case .map:
            return L10n.menuObjectMappingButton
        case .arRouting:
            return L10n.menuARButton
        case .menu:
            return L10n.menuTitle
        }
    }

    var iconImage: UIImage {
        switch self {
        case .segmentation:
            return Asset.Assets.icon1.image
        case .laneDetection:
            return Asset.Assets.icon2.image
        case .distanceToObject:
            return Asset.Assets.collisionDetection.image
        case .signsDetection:
            return Asset.Assets.icon4.image
        case .map:
            return Asset.Assets.icon5.image
        case .objectDetection:
            return Asset.Assets.icon6.image
        case .arRouting:
            return Asset.Assets.icon7.image
        case .menu:
            return UIImage()
        }
    }
}

private class MenuItemButton: UIView {
    private let padding: CGFloat = 8

    private let action: () -> Void

    init(for screen: Screen, action: @escaping (Screen) -> Void) {
        self.action = { action(screen) }

        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -padding),
        ])

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
        ])

        titleLabel.text = screen.title
        imageView.image = screen.iconImage

        let gestureRecogrizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(gestureRecogrizer)
    }

    @objc
    func tap() {
        action()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
