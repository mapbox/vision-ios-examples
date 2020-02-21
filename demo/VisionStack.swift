import UIKit

class VisionStack {
    var viewController: UIViewController {
        baseLevel.viewController
    }
    let baseLevel: BaseLevel
    let content: VisionStackLayer

    static func createDefault(with visionBundle: VisionBundle) -> VisionStack {
        let baseLevel = BaseLevel(with: visionBundle)
        let content = VisionStackLayer()
        baseLevel.viewController.view.addSubview(content)
        NSLayoutConstraint.activate([
            baseLevel.viewController.view.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            baseLevel.viewController.view.centerYAnchor.constraint(equalTo: content.centerYAnchor),
            baseLevel.viewController.view.heightAnchor.constraint(equalTo: content.heightAnchor),
            baseLevel.viewController.view.widthAnchor.constraint(equalTo: content.widthAnchor)
        ])
        return VisionStack(baseLevel: baseLevel, content: content)
    }

    init(baseLevel: BaseLevel, content: VisionStackLayer) {
        self.baseLevel = baseLevel
        self.content = content
    }
}
