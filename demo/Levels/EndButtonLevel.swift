import UIKit

class EndButtonLevel: VisionStackLevel {
    private enum Constants {
        static let inset: CGFloat = 18.0
        static let height: CGFloat = 44.0
        static let width: CGFloat = 90.0
    }

    private let endButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("End", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.red, for: .normal)
        button.setBackgroundColor(UIColor(white: 0, alpha: 0.85), for: .normal)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTriggerPrimaryAction), for: .primaryActionTriggered)
        return button
    }()

    private let completion: (() -> Void)?

    init(_ completion: @escaping () -> Void) {
        self.completion = completion

        super.init()

        addSubview(endButton)
        NSLayoutConstraint.activate([
            endButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.inset),
            endButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.inset),
            endButton.heightAnchor.constraint(equalToConstant: Constants.height),
            endButton.widthAnchor.constraint(equalToConstant: Constants.width),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTriggerPrimaryAction() {
        completion?()
    }
}
