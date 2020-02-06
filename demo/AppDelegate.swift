import Crashlytics
import Fabric
import MapboxVision
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)
    private var interactor: ContainerInteractor?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = MTLCreateSystemDefaultDevice()

        application.isIdleTimerDisabled = true

        Fabric.with([Crashlytics.self])

        window.rootViewController = makeRootViewController()
        window.makeKeyAndVisible()

        return true
    }

    private func makeRootViewController() -> UIViewController {
        if LicenseController.checkSubmission() {
            return launchVision()
        } else {
            return launchLicense()
        }
    }

    private func launchVision() -> UIViewController {
        let containerController = ContainerViewController()

        containerController.visionViewController = VisionPresentationViewController()

        let menuViewController = MenuViewController()
        containerController.menuViewController = menuViewController

        let alertPlayer = AlertSoundPlayer()

        interactor = ContainerInteractor(dependencies: ContainerInteractor.Dependencies(
            alertPlayer: alertPlayer,
            presenter: containerController
        ))
        containerController.delegate = interactor
        menuViewController.delegate = interactor

        let _ = ReplaySessionManager()

        return containerController
    }

    private func launchLicense() -> UIViewController {
        let viewController = LicenseViewController()
        viewController.licenseDelegate = self
        return viewController
    }
}

extension AppDelegate: LicenseDelegate {
    func licenseSubmitted() {
        LicenseController.submit()
        window.rootViewController = launchVision()
    }
}
