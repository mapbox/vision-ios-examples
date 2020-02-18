import UIKit

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
        self == .lane || self == .laneAndFence
    }

    var containsFence: Bool {
        self == .fence || self == .laneAndFence
    }
}

class ARModeSwitcherLevel: VisionStackLevel {
    private weak var visionStack: VisionStack?
    private var activeARFeature: ARFeature = .lane {
        didSet {
            visionStack?.baseLevel.ar(isLaneVisible: activeARFeature.containsLane, isFenceVisible: activeARFeature.containsFence)
        }
    }

    init(with visionStack: VisionStack) {
        self.visionStack = visionStack
        super.init()

        let featureSwitchButton = UIButton()
        featureSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        featureSwitchButton.setTitle("", for: .normal)
        addSubview(featureSwitchButton)
        featureSwitchButton.addTarget(self, action: #selector(switchARFeature), for: .primaryActionTriggered)
        NSLayoutConstraint.activate([
            featureSwitchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            featureSwitchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            featureSwitchButton.heightAnchor.constraint(equalTo: heightAnchor),
            featureSwitchButton.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func switchARFeature() {
        activeARFeature = activeARFeature.next
    }
}
