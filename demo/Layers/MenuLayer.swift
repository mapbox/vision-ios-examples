import UIKit

final class MenuLayer: VisionStackLayer {
    // MARK: Private properties

    let menuItems: [TeaserMenuItem]
    private var didChoose: ((TeaserMenuItem) -> Void)?

    func didChoose(_ didChooseCallback: @escaping (TeaserMenuItem) -> Void) {
        didChoose = didChooseCallback
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    init(with menuItems: [TeaserMenuItem]) {
        self.menuItems = menuItems
        super.init()

        backgroundColor = UIColor.black.withAlphaComponent(0.75)

        let select: (TeaserMenuItem) -> Void = { [weak self] menuItem in
            self?.didChoose?(menuItem)
        }

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

        let topLineCellsNumber = menuItems.count / 2 + menuItems.count % 2
        let bottomLineCellNumber = menuItems.count / 2

        let topStack = createStack(subviews: menuItems.prefix(topLineCellsNumber).map { MenuItemButton(for: $0, action: select) },
                                   alignment: .bottom,
                                   separator: verticalTopLine)
        let bottomStack = createStack(subviews: menuItems.suffix(bottomLineCellNumber).map { MenuItemButton(for: $0, action: select) },
                                      alignment: .top,
                                      separator: verticalBottomLine)

        layout(topStack: topStack, bottomStack: bottomStack, withDependencyOn: centerLine)
    }

    // MARK: Private functions

    private func createStack(
        subviews: [UIView],
        alignment: UIStackView.Alignment,
        separator: () -> UIView
    ) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = alignment

        addSubview(stack)

        for subview in subviews {
            stack.addArrangedSubview(subview)
            subview.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.25).isActive = true

            if subview != subviews.last {
                stack.addArrangedSubview(separator())
            }
        }
        return stack
    }

    private func verticalTopLine() -> UIImageView {
        UIImageView(image: Asset.Assets.lineTopBottom.image)
    }

    private func verticalBottomLine() -> UIImageView {
        let verticalBottomLine = UIImageView(image: Asset.Assets.lineTopBottom.image)
        verticalBottomLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        return verticalBottomLine
    }

    private func addToView(titleImageView: UIImageView) {
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleImageView)
        NSLayoutConstraint.activate([
            titleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 28),
        ])
    }

    private func addToView(centerLineImageView: UIImageView) {
        centerLineImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(centerLineImageView)
        NSLayoutConstraint.activate([
            centerLineImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            centerLineImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: 18),
            centerLineImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
        ])
    }

    private func addToView(leftLineImageView: UIImageView, withDependencyOn centerLine: UIImageView) {
        leftLineImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftLineImageView)
        NSLayoutConstraint.activate([
            leftLineImageView.centerYAnchor.constraint(equalTo: centerLine.centerYAnchor),
            leftLineImageView.trailingAnchor.constraint(equalTo: centerLine.leadingAnchor),
            leftLineImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
        ])
    }

    private func addToView(rightLineImageView: UIImageView, withDependencyOn centerLine: UIImageView) {
        rightLineImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        rightLineImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightLineImageView)
        NSLayoutConstraint.activate([
            rightLineImageView.centerYAnchor.constraint(equalTo: centerLine.centerYAnchor),
            rightLineImageView.leadingAnchor.constraint(equalTo: centerLine.trailingAnchor),
            rightLineImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25),
        ])
    }

    private func layout(topStack: UIStackView, bottomStack: UIStackView, withDependencyOn centerLine: UIImageView) {
        NSLayoutConstraint.activate([
            topStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            topStack.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            bottomStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomStack.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
        ])
    }
}

private class MenuItemButton: UIView {
    private static let padding: CGFloat = 8
    private static let cellHeight: CGFloat = 147.0

    private let action: () -> Void

    init(for screen: TeaserMenuItem, action: @escaping (TeaserMenuItem) -> Void) {
        self.action = { action(screen) }

        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -MenuItemButton.padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: MenuItemButton.padding),
            heightAnchor.constraint(equalToConstant: MenuItemButton.cellHeight),
        ])

        titleLabel.text = screen.name
        imageView.image = screen.icon

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
