import MapboxVision
import XCTest

@testable import demo

class SafetyScreenTestCase: XCTestCase {
    let distanceState = SafetyState.distance(frame: WorldDescription.bbox, distance: WorldDescription.distance - SafetyState.bonnetAdjustment, canvasSize: VisionManager.shared.frameSize)

    var presenter: MockContainerPresenter!
    var interactor: ContainerInteractor!
    var alertPlayer: MockAlertPlayer!

    override func setUp() {
        super.setUp()
        presenter = MockContainerPresenter()
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
        super.tearDown()
    }

    func testCriticalWithAnotherNotTriggeredObject() {
        let worldDescription = WorldDescription([(.car, .critical), (.person, .notTriggered)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let result = SafetyState.collisions([SafetyState.Collision(objectType: .car, state: .critical, boundingBox: WorldDescription.bbox)], canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == result, "Collision Alert should be presented in spite of not triggered another object")
    }

    func testCriticalWithAnotherWarningObject() {
        let worldDescription = WorldDescription([(.car, .critical), (.bicycle, .warning)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let result = SafetyState.collisions([SafetyState.Collision(objectType: .car, state: .critical, boundingBox: WorldDescription.bbox)], canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == result, "Collision Alert should be presented in spite of bicycle")
    }

    func testWarningWithAnotherNotTriggeredObject() {
        let worldDescription = WorldDescription([(.car, .warning), (.person, .notTriggered)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let result = SafetyState.collisions([SafetyState.Collision(objectType: .car, state: .warning, boundingBox: WorldDescription.bbox)], canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == result, "Collision Warning should be presented in spite of not triggered another object")
    }

    func testWarningWithAnotherUnsupportedCriticalObject() {
        let worldDescription = WorldDescription([(.car, .warning), (.sign, .critical)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let result = SafetyState.collisions([SafetyState.Collision(objectType: .car, state: .warning, boundingBox: WorldDescription.bbox)], canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == result, "Collision Warning should be presented in spite of unsupported ciritcal object")
    }

    func testWarningWithPersonObject() {
        let worldDescription = WorldDescription([(.car, .warning), (.person, .warning)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let warningState = SafetyState.collisions(
            [
                SafetyState.Collision(objectType: .car, state: .warning, boundingBox: WorldDescription.bbox),
                SafetyState.Collision(objectType: .person, state: .warning, boundingBox: WorldDescription.bbox),
            ],
            canvasSize: VisionManager.shared.frameSize
        )
        XCTAssert(presenter.currentSafetyState == warningState, "Two different Collision objects should be presented")
    }

    func testDistanceToLeadCar() {
        let worldDescription = WorldDescription([(.car, .notTriggered)], forwardCarIndex: 0)
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        XCTAssert(presenter.currentSafetyState == distanceState, "Distance to lead car should be presented")
    }

    func testDistanceToLeadObject() {
        let worldDescription = WorldDescription([(.sign, .notTriggered)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        XCTAssert(presenter.currentSafetyState == .none, "Distance to lead sign shouldn't be presented")
    }

    func testChaningState() {
        let worldDescription = WorldDescription([(.car, .warning)])
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        let result = SafetyState.collisions([SafetyState.Collision(objectType: .car, state: .warning, boundingBox: WorldDescription.bbox)], canvasSize: VisionManager.shared.frameSize)
        XCTAssert(presenter.currentSafetyState == result, "Collision Warning should be presented")

        let anotherWorldDescription = WorldDescription([(.car, .notTriggered)], forwardCarIndex: 0)
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: anotherWorldDescription)
        XCTAssert(presenter.currentSafetyState == distanceState, "Distance to lead car should be presented")
    }

    func testForwarCar() {
        let worldDescription = WorldDescription([(.person, .notTriggered), (.car, .notTriggered)], forwardCarIndex: 1)
        interactor.visionManager(VisionManager.shared, didUpdateWorldDescription: worldDescription)
        XCTAssert(presenter.currentSafetyState == distanceState, "Distance to lead car should be presented")
    }
}

extension WorldDescription {
    static let distance: Double = 5.0

    static let bbox: CGRect = .zero
    static let coords = WorldCoordinate(x: 0, y: 0, z: 0)

    convenience init(_ params: [(ObjectType, CollisionState)], forwardCarIndex: Int? = nil) {
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
                  forwardCar: forwardCarIndex.map { objects[$0] },
                  objects: objects,
                  collisionObjects: collisionObjects)
    }
}
