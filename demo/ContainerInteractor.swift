//
//  ContainerInteractor.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import VisionSDK
import CoreLocation

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
    func presentSegmentation()
    func presentObjectDetection()
    func presentDistanceToObject()
    func presentSignDetection()
    func presentLaneDetection()
    func presentMap(center: CLLocation)
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
        
        switch screen {
        case .segmentation:
            presenter.presentSegmentation()
        case .laneDetection:
            presenter.presentLaneDetection()
        case .distanceToObject:
            presenter.presentDistanceToObject()
        case .signsDetection:
            presenter.presentSignDetection()
        case .objectDetector:
            presenter.presentObjectDetection()
        case .map:
            presenter.presentMap(center: lastLocation)
        }

        presenter.presentBackButton(isVisible: true)
        presenter.dismissMenu()
    }
    
    deinit {
        visionManager.stop()
    }
    
    private var lastLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
}
