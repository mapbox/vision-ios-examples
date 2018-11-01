//
//  demoTests.swift
//  demoTests
//
//  Created by Maksim on 10/30/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import XCTest
import MapboxVision

@testable import demo

class SafetyScreenTestCase: XCTestCase {
    
    let distanceState = SafetyState.distance(frame: WorldDescription.bbox,
                                             distance: WorldDescription.distance,
                                             canvasSize: VisionManager.shared.frameSize)
    
    var presenter: MockContainerPresenrer!
    var interactor: ContainerInteractor!
    var alertPlayer: MockAlertPlayer!

    override func setUp() {
        presenter = MockContainerPresenrer()
        alertPlayer = MockAlertPlayer()
        interactor = ContainerInteractor(dependencies: ContainerInteractor.Dependencies(
            alertPlayer: alertPlayer,
            presenter: presenter
        ))
        
        interactor.selected(screen: .distanceToObject)
    }

    override func tearDown() {
        presenter = nil
        alertPlayer = nil
        interactor = nil
    }
    
    func testCriticalWithAnotherNotTriggeredObject() {
        
        let worldDescription = WorldDescription([(.car, .critical), (.person, .notTriggered)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        XCTAssert(presenter.currentSafetyState == .alert, "Collision Alert should be presented in spite of not triggered another object")
        XCTAssert(alertPlayer.nowPlayning == AlertSound.collisionAlertCritical, "Collision Alert critical sound should be played")
    }
    
    func testCriticalWithAnotherWarningObject() {
        
        let worldDescription = WorldDescription([(.bicycle, .critical), (.person, .warning)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        XCTAssert(presenter.currentSafetyState == .alert, "Collision Alert should be presented in spite of warning")
        XCTAssert(alertPlayer.nowPlayning == AlertSound.collisionAlertCritical, "Collision Alert critical sound should be played")
    }
    
    func testWarningWithAnotherNotTriggeredObject() {
        
        let worldDescription = WorldDescription([(.car, .warning), (.person, .notTriggered)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let warningState = SafetyState.warnings(values: [SafetyState.Warning(frame: WorldDescription.bbox, objectType: .car)],
                                                canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == warningState, "Collision Warning should be presented in spite of not triggered another object")
        XCTAssert(alertPlayer.nowPlayning == AlertSound.collisionAlertWarning, "Collision Alert warning sound should be played")
    }
    
    func testWarningWithAnotherUnsupportedCriticalObject() {
        
        let worldDescription = WorldDescription([(.car, .warning), (.sign, .critical)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let warningState = SafetyState.warnings(values: [SafetyState.Warning(frame: WorldDescription.bbox, objectType: .car)],
                                                canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == warningState, "Collision Warning should be presented in spite of unsupported ciritcal object")
        XCTAssert(alertPlayer.nowPlayning == AlertSound.collisionAlertWarning, "Collision Alert warning sound should be played")
    }
    
    func testWarningWithAnotherWarningObject() {
        
        let worldDescription = WorldDescription([(.car, .warning), (.car, .warning)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let warningState = SafetyState.warnings(values: [SafetyState.Warning(frame: WorldDescription.bbox, objectType: .car),
                                                         SafetyState.Warning(frame: WorldDescription.bbox, objectType: .car)],
                                                canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == warningState, "Two Collision Warnings should be presented")
        XCTAssert(alertPlayer.nowPlayning == AlertSound.collisionAlertWarning, "Collision Alert warning sound should be played")
    }
    
    func testDistanceToLeadCar() {

        let worldDescription = WorldDescription([(.car, .notTriggered)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        XCTAssert(presenter.currentSafetyState == distanceState, "Distance to lead car should be presented")
        XCTAssert(alertPlayer.nowPlayning == nil, "Alert player shouldn't play any sound")
    }
    
    func testDistanceToLeadObject() {
        
        let worldDescription = WorldDescription([(.sign, .notTriggered)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        XCTAssert(presenter.currentSafetyState == .none, "Distance to lead sign shouldn't be presented")
        XCTAssert(alertPlayer.nowPlayning == nil, "Alert player shouldn't play any sound")
    }
    
    func testChaningState() {
        
        let worldDescription = WorldDescription([(.car, .warning)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let warningState = SafetyState.warnings(values: [SafetyState.Warning(frame: WorldDescription.bbox, objectType: .car)],
                                                canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == warningState, "Collision Warning should be presented")
        XCTAssert(alertPlayer.nowPlayning == AlertSound.collisionAlertWarning, "Collision Alert warning sound should be played")
        
        let anotherWorldDescription = WorldDescription([(.car, .notTriggered)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: anotherWorldDescription)
        XCTAssert(presenter.currentSafetyState == distanceState, "Distance to lead car should be presented")
        XCTAssert(alertPlayer.nowPlayning == nil, "Alert player shouldn't play any sound")
    }
    
    func testForwarCar() {
        
        let worldDescription = WorldDescription([(.person, .notTriggered), (.car, .notTriggered)], forwardCarIndex: 1)
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        XCTAssert(presenter.currentSafetyState == distanceState, "Distance to lead car should be presented")
        XCTAssert(alertPlayer.nowPlayning == nil, "Alert player shouldn't play any sound")
    }
}

extension WorldDescription {
    
    static let distance: Double = 1.0
    
    static let bbox: CGRect = .zero
    static let coords = WorldCoordinate(x: 0, y: 0, z: 0)
    
    convenience init(_ params: [(ObjectType, CollisionState)], forwardCarIndex: UInt = 0) {
        
        var objects: [ObjectDescription] = []
        var collisionObjects: [CollisionObjectDescription] = []
        
        for param in params {
            let detection = Detection(identifier: Identifier(),
                                      boundingBox: WorldDescription.bbox,
                                      objectType: param.0,
                                      confidence: 0)
            
            let object = ObjectDescription(identifier: Identifier(),
                                          distance: WorldDescription.distance,
                                          worldCoordinate: WorldDescription.coords,
                                          detection: detection)
            objects.append(object)
            
            let collision = CollisionObjectDescription(object: object,
                                                       timeToImpact: 0,
                                                       state: param.1)
            collisionObjects.append(collision)
        }
        
        self.init(identifier: Identifier(),
                  forwardCarIndex: NSNumber(value: forwardCarIndex),
                  objects: objects,
                  collisionObjects: collisionObjects)
    }
}

class MockContainerPresenrer: ContainerPresenter {
    
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
    
    func dismissMenu() {}
    
    func dismissCurrent() {}
}

class MockAlertPlayer: AlertPlayer {
    
    var nowPlayning: AlertSound?
    
    func play(sound: AlertSound, repeated: Bool) {
        nowPlayning = sound
    }
    
    func stop() {
        nowPlayning = nil
    }
}
