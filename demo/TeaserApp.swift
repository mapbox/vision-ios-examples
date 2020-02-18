import MapboxVisionAR
import UIKit

class TeaserApp {
    let viewController: UIViewController

    private let visionBundle: VisionBundle
    private let visionStack: VisionStack
    private var menuLevel: MenuLevel?

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
                visionStack.clear()
                guard let self = self else { return }
                let signs = DetectedSignsLevel(with: self.visionBundle)
                visionStack.add(level: signs)
            },
            TeaserMenuItem(
                name: L10n.menuSegmentationButton,
                icon: Asset.Assets.icon1.image
            ) { visionStack in
                visionStack.baseLevel.segmentation()
                visionStack.clear()
            },
            TeaserMenuItem(
                name: L10n.menuObjectDetectionButton,
                icon: Asset.Assets.icon6.image
            ) { visionStack in
                visionStack.baseLevel.detection()
                visionStack.clear()
            },
            TeaserMenuItem(
                name: L10n.menuCollisionDetectionButton,
                icon: Asset.Assets.collisionDetection.image
            ) { [weak visionBundle] visionStack in
                visionStack.baseLevel.clear()
                visionStack.clear()
                guard let safetyBundle = visionBundle?.safetyBundle else { return }
                visionStack.add(level: SafetyLevel(with: safetyBundle))
            },
            TeaserMenuItem(
                name: L10n.menuARButton,
                icon: Asset.Assets.icon7.image
            ) { [weak visionBundle] visionStack in
                visionStack.clear()
                let map = ARMapNavigationLevel()
                visionStack.add(level: map)
                map.completion = { [weak visionBundle, weak visionStack, unowned map] route in
                    guard let visionStack = visionStack else { return }
                    visionStack.clearLevels()
                    visionBundle?.arBundle.arManager.set(route: Route(route: route))
                    visionStack.baseLevel.ar()
                    visionStack.add(level: ARModeSwitcherLevel(with: visionStack))
                    let navigation = NavigationLevel(with: route)
                    visionStack.add(level: navigation)
                    visionStack.add(level: EndButtonLevel { [weak visionStack, map] in
                        guard let visionStack = visionStack else { return }
                        visionStack.clearLevels()
                        visionStack.add(level: map)
                    })
                }
            },
            TeaserMenuItem(
                name: L10n.menuLaneDetectionButton,
                icon: Asset.Assets.icon2.image
            ) { [weak visionBundle] visionStack in
                visionStack.baseLevel.clear()
                visionStack.clear()
                guard let visionBundle = visionBundle else { return }
                visionStack.add(level: LaneDetectionsLevel(with: visionBundle))
            }
        ]

        let menuLevel = MenuLevel(with: menuItems)
        visionStack.add(level: menuLevel)
        visionStack.add(level: InfoButtonLevel(with: visionStack))
        let backButtonLevel = BackButtonLevel { [weak menuLevel, weak visionStack, weak visionBundle] in
            guard let menuLevel = menuLevel, let visionStack = visionStack else { return }
            visionStack.clear()
            visionStack.baseLevel.clear()
            visionStack.add(level: menuLevel)
            visionStack.add(level: InfoButtonLevel(with: visionStack))
            DispatchQueue.main.async { [weak visionBundle] in
                visionBundle?.groomWeak()
            }
        }
        menuLevel.didChoose { [weak visionStack] menuItem in
            guard let controlStack = visionStack else { return }
            menuItem.activateBlock(controlStack)
            visionStack?.pin(level: backButtonLevel)
        }

        self.menuLevel = menuLevel

        guard let navigationController = self.viewController as? UINavigationController else { return }
        navigationController.navigationBar.isHidden = true
        self.visionBundle.start()
    }
}
