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

    var window: UIWindow?
    private var interactor: ContainerInteractor?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let _ = MTLCreateSystemDefaultDevice()
        
        application.isIdleTimerDisabled = true
        
        Fabric.with([Crashlytics.self])
        
        guard let containerController = window?.rootViewController as? ContainerViewController else {
            assertionFailure("Couldn't find container view controller")
            return false
        }
        
        let visionManager = VisionManager.shared
        let visionViewController = visionManager.createPresentation()
        
        containerController.visionViewController = visionViewController
        
        let menuViewController = MenuViewController()
        containerController.menuViewController = menuViewController
        
        interactor = ContainerInteractor(presenter: containerController)
        containerController.delegate = interactor
        menuViewController.delegate = interactor

        return true
    }
}

