//
//  ContainerInteractor.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import VisionSDK
import VisionCore

enum Screen {
    case signsDetection
    case segmentation
    case objectDetection
    case distanceToObject
    case map
    case laneDetection
}

protocol ContainerPresenter: class {
    func presentMenu()
    func presentVision()
    func present(screen: Screen)
    func present(signClassifications: SignClassifications?)
    func present(roadDescription: RoadDescription?)
    func present(worldDescription: WorldDescription?)
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

final class ContainerInteractor {
    
    private var currentScreen: Screen?
    private let presenter: ContainerPresenter
    private let visionManager: VisionManager
    
    init(presenter: ContainerPresenter) {
        self.presenter = presenter
        
        visionManager = VisionManager.shared
        visionManager.delegate = self
        visionManager.start()
        
        presenter.presentBackButton(isVisible: false)
        presenter.presentVision()
        presenter.presentMenu()
    }
    
    deinit {
        visionManager.stop()
    }
}

extension ContainerInteractor: ContainerDelegate {
    
    func backButtonPressed() {
        presenter.dismissCurrent()
        presenter.presentBackButton(isVisible: false)
        presenter.presentMenu()
        currentScreen = nil
    }
}

extension ContainerInteractor: MenuDelegate {
    
    func selected(screen: Screen) {
        presenter.dismissCurrent()
        presenter.dismissMenu()
        presenter.present(screen: screen)
        presenter.presentBackButton(isVisible: true)
        currentScreen = screen
    }
}

extension ContainerInteractor: VisionManagerDelegate {
    
    func visionManager(_ visionManager: VisionManager, didUpdateSegmentation segmentation: SegmentationMask?) {
        
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateDetections detections: Detections?) {
        
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateSignClassifications classifications: SignClassifications?) {
        guard case .some(.signsDetection) = currentScreen else { return }
        presenter.present(signClassifications: classifications)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateRoadDescription roadDescription: RoadDescription?) {
        guard case .some(.laneDetection) = currentScreen else { return }
        presenter.present(roadDescription: roadDescription)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateEstimatedPosition estimatedPosition: Position?) {
        
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateWorldDescription worldDescription: WorldDescription?) {
        guard case .some(.distanceToObject) = currentScreen else { return }
        presenter.present(worldDescription: worldDescription)
    }
    
    
}
