import Foundation
import MapboxVisionAR

class ARScreen {
    private let visionBundle: VisionBundle
    private let visionStack: VisionStack

    init(visionBundle: VisionBundle, visionStack: VisionStack) {
        self.visionBundle = visionBundle
        self.visionStack = visionStack
        resetViews()
    }

    func resetViews() {
        visionStack.content.clear()
        let map = ARMapNavigationLayer()
        visionStack.content.add(layer: map)
        map.completion = { [weak visionBundle, weak visionStack, unowned map] route in
            guard let visionStack = visionStack else { return }
            visionStack.content.clear()
            visionBundle?.arBundle.arManager.set(route: Route(route: route))
            visionStack.baseLevel.ar()
            visionStack.content.add(layer: ARModeSwitcherLayer(with: visionStack))
            let navigation = NavigationLayer(with: route)
            visionStack.content.add(layer: navigation)
            visionStack.content.add(layer: EndButtonLayer { [weak visionStack, map] in
                guard let visionStack = visionStack else { return }
                visionStack.content.clear()
                visionStack.content.add(layer: map)
            })
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
