import UIKit

class BackButtonLevel: VisionStackLevel {
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Asset.Assets.back.image, for: .normal)
        return button
    }()

    let callback: () -> Void

    init(withCallback callback: @escaping () -> Void) {
        self.callback = callback

        super.init()

        set(transparency: 0.0)
        addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            backButton.widthAnchor.constraint(lessThanOrEqualToConstant: 44),
            backButton.heightAnchor.constraint(lessThanOrEqualToConstant: 44),
        ])
        backButton.addTarget(self, action: #selector(BackButtonLevel.didTap), for: .primaryActionTriggered)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTap() {
        callback()
    }
}
