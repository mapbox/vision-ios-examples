//
//  ContainerInteractor.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision

enum Screen {
    case signsDetection
    case segmentation
    case objectDetection
    case distanceToObject
    case map
    case laneDetection
}

struct DistanceToCar {
    let leftPosition: CGPoint
    let rightPosition: CGPoint
    let distance: Double
}

protocol ContainerPresenter: class {
    func presentMenu()
    func presentVision()
    func present(screen: Screen)
    func present(signs: [ImageAsset])
    func present(roadDescription: RoadDescription?)
    func present(distanceToCar: DistanceToCar?, canvasSize: CGSize)
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

private let signTrackerMaxCapacity = 5

final class ContainerInteractor {
    
    private var currentScreen: Screen?
    private let presenter: ContainerPresenter
    private let visionManager: VisionManager
    
    private let signTracker = Tracker<SignClassification>(maxCapacity: signTrackerMaxCapacity)
    private var signTrackerUpdateTimer: Timer?
    
    init(presenter: ContainerPresenter) {
        self.presenter = presenter
        
        visionManager = VisionManager.shared
        visionManager.delegate = self
        visionManager.start()
        
        presenter.presentBackButton(isVisible: false)
        presenter.presentVision()
        presenter.presentMenu()
    }
    
    private func scheduleSignTrackerUpdates() {
        signTrackerUpdateTimer?.invalidate()
        
        signTrackerUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            let signs = self.signTracker.getCurrent().compactMap { sign in
                return sign.icon(over: false, market: .us)
            }
            self.presenter.present(signs: signs)
        }
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
        
        if case .some(.signsDetection) = currentScreen {
            signTrackerUpdateTimer?.invalidate()
        }
        
        currentScreen = nil
    }
}

extension ContainerInteractor: MenuDelegate {
    
    func selected(screen: Screen) {
        presenter.dismissCurrent()
        presenter.dismissMenu()
        
        if case .signsDetection = screen {
            scheduleSignTrackerUpdates()
        }
        
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
        guard case .some(.signsDetection) = currentScreen, let items = classifications?.items else { return }
        signTracker.update(items)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateRoadDescription roadDescription: RoadDescription?) {
        guard case .some(.laneDetection) = currentScreen else { return }
        presenter.present(roadDescription: roadDescription)
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateEstimatedPosition estimatedPosition: Position?) {
        
    }
    
    func visionManager(_ visionManager: VisionManager, didUpdateWorldDescription worldDescription: WorldDescription?) {
        guard case .some(.distanceToObject) = currentScreen else { return }
        
        guard
            let roadDescription = visionManager.roadDescription,
            let car = worldDescription?.objects.first,
            roadDescription.currentLane < roadDescription.lanes.count,
            car.objectType == .car
        else {
            presenter.present(distanceToCar: nil, canvasSize: visionManager.frameSize)
            return
        }
        
        let width = roadDescription.lanes[roadDescription.currentLane].width

        let carLeftPosition = visionManager.worldToPixel(worldCoordinate: WorldCoordinate(x: car.worldCoordinate.x - (width / 2), y: car.worldCoordinate.y, z: car.worldCoordinate.z))
        let carRightPosition = visionManager.worldToPixel(worldCoordinate: WorldCoordinate(x: car.worldCoordinate.x + (width / 2), y: car.worldCoordinate.y, z: car.worldCoordinate.z))
        
        let distanceToCar = DistanceToCar(
            leftPosition: carLeftPosition,
            rightPosition: carRightPosition,
            distance: car.distance
        )
        
        presenter.present(distanceToCar: distanceToCar, canvasSize: visionManager.frameSize)
    }
    
    
}
