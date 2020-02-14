import UIKit
import MapboxVision
import MapboxVisionAR

class VisionStack {
    var viewController: UIViewController {
        return baseLevel.viewController
    }
    let baseLevel: BaseLevel
    private var levels: [VisionStackLevel] = []
    private var pinnedLevels: [VisionStackLevel] = []
    private let viewsStack: UIView
    private let pinnedViewsStack: VisionStackLevel

    init(with visionBundle: VisionBundle) {
        baseLevel = BaseLevel(with: visionBundle)
        viewsStack = UIView(frame: baseLevel.viewController.view.bounds)
        viewsStack.translatesAutoresizingMaskIntoConstraints = true
        baseLevel.viewController.view.addSubview(viewsStack)
        pinnedViewsStack = VisionStackLevel()
        viewsStack.addSubview(pinnedViewsStack)
        NSLayoutConstraint.activate([
            viewsStack.centerXAnchor.constraint(equalTo: pinnedViewsStack.centerXAnchor),
            viewsStack.centerYAnchor.constraint(equalTo: pinnedViewsStack.centerYAnchor),
            viewsStack.heightAnchor.constraint(equalTo: pinnedViewsStack.heightAnchor),
            viewsStack.widthAnchor.constraint(equalTo: pinnedViewsStack.widthAnchor)
        ])
    }

    func add(level: VisionStackLevel) {
        levels.append(level)
        level.translatesAutoresizingMaskIntoConstraints = false
        viewsStack.insertSubview(level, belowSubview: pinnedViewsStack)
        NSLayoutConstraint.activate([
            viewsStack.centerXAnchor.constraint(equalTo: level.centerXAnchor),
            viewsStack.centerYAnchor.constraint(equalTo: level.centerYAnchor),
            viewsStack.heightAnchor.constraint(equalTo: level.heightAnchor),
            viewsStack.widthAnchor.constraint(equalTo: level.widthAnchor)
        ])
    }

    func pin(level: VisionStackLevel) {
        pinnedLevels.append(level)
        level.translatesAutoresizingMaskIntoConstraints = false
        pinnedViewsStack.addSubview(level)
        NSLayoutConstraint.activate([
            pinnedViewsStack.centerXAnchor.constraint(equalTo: level.centerXAnchor),
            pinnedViewsStack.centerYAnchor.constraint(equalTo: level.centerYAnchor),
            pinnedViewsStack.heightAnchor.constraint(equalTo: level.heightAnchor),
            pinnedViewsStack.widthAnchor.constraint(equalTo: level.widthAnchor)
        ])
    }

    func remove(level: VisionStackLevel) {
        levels = levels.filter { subview in
            if subview === level {
                level.removeFromSuperview()
                return false
            }
            return true
        }
    }

    func unpin(level: VisionStackLevel) {
        pinnedLevels = pinnedLevels.filter { subview in
            if subview === level {
                level.removeFromSuperview()
                return false
            }
            return true
        }
    }

    func clearLevels() {
        levels.forEach { level in
            level.removeFromSuperview()
        }
        levels = []
    }

    func clear() {
        clearLevels()
        pinnedLevels.forEach { level in
            level.removeFromSuperview()
        }
        pinnedLevels = []
    }
}

class BaseLevel {
    let viewController: UIViewController
    var visionViewController: VisionPresentationViewController?
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
        arViewController.set(arManager: visionBundle.ar.arManager)
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
