import MapboxVision
import MapboxVisionAR
import UIKit

class VisionStack {
    var viewController: UIViewController {
        baseLevel.viewController
    }
    let baseLevel: BaseLevel
    let content: VisionStackLayer
    let top: VisionStackLayer

    init(with visionBundle: VisionBundle) {
        baseLevel = BaseLevel(with: visionBundle)
        content = VisionStackLayer()
        top = VisionStackLayer()
        viewController.view.addSubview(content)
        NSLayoutConstraint.activate([
            viewController.view.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            viewController.view.centerYAnchor.constraint(equalTo: content.centerYAnchor),
            viewController.view.heightAnchor.constraint(equalTo: content.heightAnchor),
            viewController.view.widthAnchor.constraint(equalTo: content.widthAnchor)
        ])
        viewController.view.addSubview(top)
        NSLayoutConstraint.activate([
            viewController.view.centerXAnchor.constraint(equalTo: top.centerXAnchor),
            viewController.view.centerYAnchor.constraint(equalTo: top.centerYAnchor),
            viewController.view.heightAnchor.constraint(equalTo: top.heightAnchor),
            viewController.view.widthAnchor.constraint(equalTo: top.widthAnchor)
        ])
    }
}

class BaseLevel {
    let viewController: UIViewController
    private var visionViewController: VisionPresentationViewController?
    private var arViewController: VisionARViewController?
    private weak var visionBundle: VisionBundle?

    init(with visionBundle: VisionBundle) {
        self.visionBundle = visionBundle
        self.viewController = UIViewController()
        configureVision()
    }

    func configureVision() {
        if let arViewController = arViewController {
            arViewController.willMove(toParent: nil)
            arViewController.view.removeFromSuperview()
            arViewController.removeFromParent()
            self.arViewController = nil
        }
        if visionViewController == nil {
            guard let visionBundle = visionBundle else { return }
            let visionViewController = VisionPresentationViewController()
            visionViewController.set(visionManager: visionBundle.visionManager)
            viewController.view.insertSubview(visionViewController.view, at: 0)
            viewController.addChild(visionViewController)
            visionViewController.didMove(toParent: viewController)
            self.visionViewController = visionViewController
        }
    }

    func configureAR() {
        guard arViewController == nil else { return }
        guard let visionBundle = visionBundle else { return }
        let arViewController = VisionARViewController()
        arViewController.set(arManager: visionBundle.arBundle.arManager)
        viewController.view.insertSubview(arViewController.view, at: 1)
        viewController.addChild(arViewController)
        arViewController.didMove(toParent: viewController)
        self.arViewController = arViewController
    }

    func clear() {
        configureVision()
        guard let visionViewController = visionViewController else { return }
        visionViewController.visualizationMode = .clear
    }

    func ar(laneVisualParams: LaneVisualParams = LaneVisualParams(), fenceVisualParams: FenceVisualParams = FenceVisualParams(), isLaneVisible: Bool = true, isFenceVisible: Bool = false) {
        configureAR()
        arViewController?.isLaneVisible = isLaneVisible
        arViewController?.isFenceVisible = isFenceVisible
        arViewController?.set(laneVisualParams: laneVisualParams)
        arViewController?.set(fenceVisualParams: fenceVisualParams)
    }

    func detection() {
        configureVision()
        guard let visionViewController = visionViewController else { return }
        visionViewController.visualizationMode = .detection
    }

    func segmentation() {
        configureVision()
        guard let visionViewController = visionViewController else { return }
        visionViewController.visualizationMode = .segmentation
    }
}
