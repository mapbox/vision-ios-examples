import MapboxVisionAR
import UIKit

class TeaserApp {
    let viewController: UIViewController

    private let visionBundle: VisionBundle
    private let visionStack: VisionStack
    private var menuLayer: MenuLayer?

    init() {
        visionBundle = VMObserver().observe()
        visionStack = VisionStack(with: visionBundle)
        viewController = UINavigationController()
        viewController.addChild(visionStack.viewController)
        let menuItems = [
            TeaserMenuItem(
                name: L10n.menuSignDetectionButton,
                icon: Asset.Assets.icon4.image
            ) { [weak self] visionStack in
                visionStack.baseLevel.clear()
                visionStack.content.clear()
                guard let self = self else { return }
                let signs = DetectedSignsLayer(with: self.visionBundle)
                visionStack.content.add(layer: signs)
            },
            TeaserMenuItem(
                name: L10n.menuSegmentationButton,
                icon: Asset.Assets.icon1.image
            ) { visionStack in
                visionStack.baseLevel.segmentation()
                visionStack.content.clear()
            },
            TeaserMenuItem(
                name: L10n.menuObjectDetectionButton,
                icon: Asset.Assets.icon6.image
            ) { visionStack in
                visionStack.baseLevel.detection()
                visionStack.content.clear()
            },
            TeaserMenuItem(
                name: L10n.menuCollisionDetectionButton,
                icon: Asset.Assets.collisionDetection.image
            ) { [weak visionBundle] visionStack in
                visionStack.baseLevel.clear()
                visionStack.content.clear()
                guard let safetyBundle = visionBundle?.safetyBundle else { return }
                visionStack.content.add(layer: SafetyLayer(with: safetyBundle))
            },
            TeaserMenuItem(
                name: L10n.menuARButton,
                icon: Asset.Assets.icon7.image
            ) { [weak visionBundle] visionStack in
                visionStack.content.clear()
                let map = ARMapNavigationLayer()
                visionStack.content.add(layer: map)
                map.completion = { [weak visionBundle, weak visionStack, unowned map] route in
                    guard let visionStack = visionStack else { return }
                    visionStack.content.clear()
                    visionBundle?.arBundle.arManager.set(route: Route(route: route))
                    visionStack.baseLevel.ar()
                    visionStack.content.add(layer: ARModeSwitcherLayer(with: visionStack))
                    let navigation = NavigationLayer(with: route)
                    visionStack.content.add(layer: navigation)
                    visionStack.content.add(layer: EndButtonLayer { [weak visionStack, map] in
                        guard let visionStack = visionStack else { return }
                        visionStack.content.clear()
                        visionStack.content.add(layer: map)
                    })
                }
            },
            TeaserMenuItem(
                name: L10n.menuLaneDetectionButton,
                icon: Asset.Assets.icon2.image
            ) { [weak visionBundle] visionStack in
                visionStack.baseLevel.clear()
                visionStack.content.clear()
                guard let visionBundle = visionBundle else { return }
                visionStack.content.add(layer: LaneDetectionsLayer(with: visionBundle))
            }
        ]

        let menuLayer = MenuLayer(with: menuItems)
        visionStack.content.add(layer: menuLayer)
        visionStack.content.add(layer: InfoButtonLayer(with: visionStack))
        let backButtonLevel = BackButtonLayer { [weak menuLayer, weak visionStack, weak visionBundle] in
            guard let menuLayer = menuLayer, let visionStack = visionStack else { return }
            visionStack.content.clear()
            visionStack.baseLevel.clear()
            visionStack.content.add(layer: menuLayer)
            visionStack.content.add(layer: InfoButtonLayer(with: visionStack))
            DispatchQueue.main.async { [weak visionBundle] in
                visionBundle?.groomWeak()
            }
        }
        menuLayer.didChoose { [weak visionStack] menuItem in
            guard let controlStack = visionStack else { return }
            menuItem.activateBlock(controlStack)
            visionStack?.top.add(layer: backButtonLevel)
        }

        self.menuLayer = menuLayer

        guard let navigationController = self.viewController as? UINavigationController else { return }
        navigationController.navigationBar.isHidden = true
        self.visionBundle.start()
    }
}
