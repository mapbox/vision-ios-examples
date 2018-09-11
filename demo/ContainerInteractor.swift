//
//  ContainerInteractor.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import VisionSDK

enum Screen {
    case signsDetection
    case segmentation
    case objectDetector
    case distanceToObject
    case map
    case laneDetection
}

protocol ContainerPresenter: class {
    func presentMenu()
    func presentVision()
    func present(_ screen: Screen)
    func presentBackButton(isVisible: Bool)
    func dismissMenu()
    func dismissCurrent()
}

protocol MenuDelegate: class {
    func selected(screen: Screen)
}

@objc protocol ContainerDelegate: class {
    func backButtonPressed()
}

final class ContainerInteractor: ContainerDelegate, MenuDelegate {
    
    private let presenter: ContainerPresenter
    private let visionManager: VisionManager
    
    init(presenter: ContainerPresenter) {
        self.presenter = presenter
        
        visionManager = VisionManager.shared
        visionManager.start()
        
        presenter.presentBackButton(isVisible: false)
        presenter.presentVision()
        presenter.presentMenu()
    }
    
    func backButtonPressed() {
        presenter.dismissCurrent()
        presenter.presentBackButton(isVisible: false)
        presenter.presentMenu()
    }
    
    func selected(screen: Screen) {
        presenter.dismissCurrent()
        presenter.dismissMenu()
        presenter.present(screen)
        presenter.presentBackButton(isVisible: true)
    }
    
    deinit {
        visionManager.stop()
    }
}
