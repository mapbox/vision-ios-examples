import Foundation
import MapboxVisionAR

class VisionARBundle {
    let arManager: VisionARManager

    init(_ visionBundle: VisionBundle) {
        arManager = VisionARManager.create(visionManager: visionBundle.visionManager)
    }
}
