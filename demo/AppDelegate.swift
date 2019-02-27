//
//  AppDelegate.swift
//  demo
//
//  Created by Maksim on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit
import MapboxVision
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow(frame: UIScreen.main.bounds)
    private var interactor: ContainerInteractor?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let _ = MTLCreateSystemDefaultDevice()
        
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
        
        return containerController
    }
    
    private func launchLicense() -> UIViewController {
        let viewController = WelcomeViewController()
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

