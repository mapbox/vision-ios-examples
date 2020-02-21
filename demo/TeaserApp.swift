import UIKit

class TeaserApp {
    let viewController: UIViewController

    private var visionBundle: VisionBundle
    private let visionStack: VisionStack
    private var menuLayer: MenuLayer?
    private var arScreen: ARController?

    static func createDefault() -> TeaserApp {
        let visionBundle = VisionBundle.createDefault()
        let visionStack = VisionStack.createDefault(with: visionBundle)
        let teaser = TeaserApp(visionBundle: visionBundle, visionStack: visionStack)
        teaser.visionBundle.start()
        return teaser
    }

    init(visionBundle: VisionBundle, visionStack: VisionStack) {
        self.visionBundle = visionBundle
        self.visionStack = visionStack
        viewController = UINavigationController()
        viewController.addChild(visionStack.viewController)
        resetViews()
    }

    func resetViews() {
        if let arScreen = arScreen {
            arScreen.resetViews()
            return
        }
        visionBundle.set(performance: .low)
        visionStack.content.clear()
        visionStack.baseLevel.clear()
        let subcontent = VisionStackLayer()

        let menuItems = [
            TeaserMenuItem(
                name: L10n.menuSignDetectionButton,
                icon: Asset.Assets.icon4.image
            ) { [weak visionBundle] visionStack in
                visionStack.baseLevel.clear()
                visionStack.content.clear()
                guard let visionBundle = visionBundle else { return }
                visionBundle.set(performance: .high)
                let signs = DetectedSignsLayer(with: visionBundle)
                visionStack.content.add(layer: signs)
            },
            TeaserMenuItem(
                name: L10n.menuSegmentationButton,
                icon: Asset.Assets.icon1.image
            ) { [weak visionBundle] visionStack in
                visionBundle?.set(performance: .high)
                visionStack.baseLevel.segmentation()
                visionStack.content.clear()
            },
            TeaserMenuItem(
                name: L10n.menuObjectDetectionButton,
                icon: Asset.Assets.icon6.image
            ) { [weak visionBundle] visionStack in
                visionBundle?.set(performance: .high)
                visionStack.baseLevel.detection()
                visionStack.content.clear()
            },
            TeaserMenuItem(
                name: L10n.menuCollisionDetectionButton,
                icon: Asset.Assets.collisionDetection.image
            ) { [weak visionBundle] visionStack in
                visionStack.baseLevel.clear()
                visionStack.content.clear()
                visionBundle?.set(performance: .medium)
                guard let safetyBundle = visionBundle?.safetyBundle else { return }
                visionStack.content.add(layer: SafetyLayer(with: safetyBundle))
            },
            TeaserMenuItem(
                name: L10n.menuARButton,
                icon: Asset.Assets.icon7.image
            ) { [weak visionBundle, weak self] visionStack in
                guard let visionBundle = visionBundle, let self = self else { return }
                self.arScreen = ARController(visionBundle: visionBundle, visionStack: visionStack)
            },
            TeaserMenuItem(
                name: L10n.menuLaneDetectionButton,
                icon: Asset.Assets.icon2.image
            ) { [weak visionBundle] visionStack in
                visionStack.baseLevel.clear()
                visionStack.content.clear()
                visionBundle?.set(performance: .medium)
                guard let visionBundle = visionBundle else { return }
                visionStack.content.add(layer: LaneDetectionsLayer(with: visionBundle))
            }
        ]

        let menuLayer = MenuLayer(with: menuItems)
        visionStack.content.add(layer: menuLayer)
        visionStack.content.add(layer: InfoButtonLayer(with: visionStack))
        let backButtonLevel = BackButtonLayer { [weak self] in
            self?.arScreen = nil
            self?.resetViews()
        }
        menuLayer.didChoose { [weak visionStack] menuItem in
            guard let visionStack = visionStack else { return }
            visionStack.content.clear()
            subcontent.clear()
            visionStack.content.add(layer: subcontent)
            menuItem.activateBlock(VisionStack(baseLevel: visionStack.baseLevel, content: subcontent))
            visionStack.content.add(layer: backButtonLevel)
        }

        self.menuLayer = menuLayer

        guard let navigationController = self.viewController as? UINavigationController else { return }
        navigationController.navigationBar.isHidden = true
    }
}
