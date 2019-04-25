//
//  MockContainerPresenrer.swift
//  demoTests
//
//  Created by Maksim on 11/6/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision

@testable import demo

class MockContainerPresenter: ContainerPresenter {
    
    var currentSafetyState: SafetyState = .none
    
    func present(safetyState: SafetyState) {
        currentSafetyState = safetyState
    }
    
    func presentVision() {}
    
    func present(screen: Screen) {}
    
    func presentBackButton(isVisible: Bool) {}
    
    func present(signs: [ImageAsset]) {}
    
    func present(roadDescription: RoadDescription?) {}
    
    func present(laneDepartureState: LaneDepartureState) {}
    
    func present(calibrationProgress: CalibrationProgress?) {}
    
    func present(speedLimit: ImageAsset?, isNew: Bool) {}
    
    func dismissCurrent() {}
}
