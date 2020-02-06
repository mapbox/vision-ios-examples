import UIKit
import MapboxVision

class ARControlStack {
    let viewController: UIViewController
    let baseLevel: BaseLevel = BaseLevel()
    private var levels: [StackLevel] = []

    init(with visionBundle: VisionBundle) {
        let visionViewController = VisionPresentationViewController()
        visionViewController.set(visionManager: visionBundle.visionManager)
        viewController = visionViewController
    }

    func add(level: StackLevel) {
        levels.append(level)
    }

    func clearLevels() {
        levels = []
    }
}

class StackLevel: UIView {
    init() {
        super.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseLevel: StackLevel {
    func clear() {}
    func ar() {}
    func detection() {}
    func segmentation() {}
}
