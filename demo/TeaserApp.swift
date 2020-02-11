import UIKit
import MapboxVisionAR

class TeaserApp {
    let vc: UIViewController

    private let visionBundle: VisionBundle
    private let visionStack: VisionStack
    private var menuLevel: MenuLevel?

    init() {
        visionBundle = VMObserver().observe()
        visionStack = VisionStack(with: visionBundle)
        vc = UINavigationController()
        vc.addChild(visionStack.viewController)
        let menuItems = [
            TeaserMenuItem(
                name: L10n.menuSignDetectionButton,
                icon: Asset.Assets.icon4.image,
                activateBlock: { [weak self] visionStack in
                    visionStack.baseLevel.clear()
                    visionStack.clear()
                    guard let self = self else { return }
                    let signs = DetectedSignsLevel(with: self.visionBundle)
                    visionStack.add(level: signs)
                }
            ),
            TeaserMenuItem(
                name: L10n.menuSegmentationButton,
                icon: Asset.Assets.icon1.image,
                activateBlock: { visionStack in
                    visionStack.baseLevel.segmentation()
                    visionStack.clear()
                }
            ),
            TeaserMenuItem(
                name: L10n.menuObjectDetectionButton,
                icon: Asset.Assets.icon6.image,
                activateBlock: { visionStack in
                    visionStack.baseLevel.detection()
                    visionStack.clear()
                }
            ),
            TeaserMenuItem(
                name: L10n.menuCollisionDetectionButton,
                icon: Asset.Assets.collisionDetection.image,
                activateBlock: { [weak visionBundle] visionStack in
                    visionStack.baseLevel.clear()
                    visionStack.clear()
                    guard let safetyBundle = visionBundle?.safety else { return }
                    visionStack.add(level: SafetyLevel(with: safetyBundle))
                }
            ),
            TeaserMenuItem(
                name: L10n.menuARButton,
                icon: Asset.Assets.icon7.image,
                activateBlock: { [weak visionBundle] visionStack in
                    visionStack.clear()
                    let map = ARMapNavigationController()
                    visionStack.add(level: map)
                    map.completion = { [weak visionBundle, weak visionStack, unowned map] route in
                        visionStack?.clearLevels()
                        visionBundle?.ar.arManager.set(route: Route(route: route))
                        visionStack?.baseLevel.ar()
                        let navigation = NavigationLevel(with: route)
                        visionStack?.add(level: navigation)
                        visionStack?.add(level: EndButtonLevel({ [weak visionStack, map] in
                            guard let visionStack = visionStack else { return }
                            visionStack.clearLevels()
                            visionStack.add(level: map)
                        }))
                    }
                }
            ),
            TeaserMenuItem(
                name: L10n.menuLaneDetectionButton,
                icon: Asset.Assets.icon2.image,
                activateBlock: { visionStack in
                    visionStack.baseLevel.clear()
                    visionStack.clear()
                }
            )
        ]

        let menuLevel = MenuLevel(with: menuItems)
        visionStack.add(level: menuLevel)
        visionStack.add(level: InfoButtonLevel(with: visionStack))
        let backButtonLevel = BackButtonLevel(withCallback: { [weak menuLevel, weak visionStack, weak visionBundle] in
            guard let menuLevel = menuLevel, let visionStack = visionStack else { return }
            visionStack.clear()
            visionStack.baseLevel.clear()
            visionStack.add(level: menuLevel)
            visionStack.add(level: InfoButtonLevel(with: visionStack))
            DispatchQueue.main.async { [weak visionBundle] in
                visionBundle?.groomWeak()
            }
        })
        menuLevel.didChoose { [weak visionStack] menuItem in
            guard let controlStack = visionStack else { return }
            menuItem.activateBlock(controlStack)
            visionStack?.pin(level: backButtonLevel)
        }

        self.menuLevel = menuLevel

        guard let navigationController = self.vc as? UINavigationController else { return }
        navigationController.navigationBar.isHidden = true
        self.visionBundle.start()
    }
}
