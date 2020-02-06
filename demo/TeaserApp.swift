import UIKit

class TeaserApp {
    let visionBundle: VisionBundle
    let controlStack: ARControlStack

    let vc: UIViewController

    init() {
        visionBundle = VMObserver().observe()
        controlStack = ARControlStack(with: visionBundle)
        vc = UINavigationController()
        vc.addChild(controlStack.viewController)

        let menuItems = [
            TeaserMenuItem(
                name: "Sign Detection",
                icon: Asset.Assets.icon1.image,
                activateBlock: { viewStack in }
            ),
            TeaserMenuItem(
                name: "Sign Detection",
                icon: Asset.Assets.icon1.image,
                activateBlock: { viewStack in
                    viewStack.baseLevel.clear()
//                    let signs = DetectedSignsLevel(visionBundle)
//                    viewStack.add(level: signs)
            }
            ),
            TeaserMenuItem(
                name: "AR Navigation",
                icon: Asset.Assets.icon2.image,
                activateBlock: { viewStack in
                    viewStack.baseLevel.ar()
                    viewStack.clearLevels()
                    let mapViewController = MapViewController()
//                    MapViewController.onChoose { route in
//                        visionBundle.ar.set(route: route)
//                    }
                }
            ),
            TeaserMenuItem(
                name: "Sign Detection",
                icon: Asset.Assets.icon1.image,
                activateBlock: { viewStack in }
            ),
            TeaserMenuItem(
                name: "Sign Detection",
                icon: Asset.Assets.icon1.image,
                activateBlock: { viewStack in }
            ),
            TeaserMenuItem(
                name: "Sign Detection",
                icon: Asset.Assets.icon1.image,
                activateBlock: { viewStack in }
            ),
            TeaserMenuItem(
                name: "Sign Detection",
                icon: Asset.Assets.icon1.image,
                activateBlock: { viewStack in }
            )
        ]
        let menu = TeaserMenu(with: menuItems)
        menu.didChoose { [weak controlStack] menuItem in
            guard let controlStack = controlStack else { return }
            menuItem.activateBlock(controlStack)
        }
        controlStack.add(level: menu)
    }
    // observe vm
    // show control stack
}
