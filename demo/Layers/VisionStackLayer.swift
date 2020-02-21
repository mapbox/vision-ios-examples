import UIKit

class VisionStackLayer: UIView {
    private var layers: [VisionStackLayer] = []

    init() {
        super.init(frame: CGRect.zero)
        set(transparency: 0.0)
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(transparency: CGFloat) {
        backgroundColor = UIColor.black.withAlphaComponent(transparency)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in subviews.reversed() {
            if subview.frame.contains(point), let result = subview.hitTest(convert(point, to: subview), with: event) {
                return result
            }
        }
        return nil
    }

    func add(layer: VisionStackLayer) {
        layers.append(layer)
        layer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(layer)
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: layer.centerXAnchor),
            centerYAnchor.constraint(equalTo: layer.centerYAnchor),
            heightAnchor.constraint(equalTo: layer.heightAnchor),
            widthAnchor.constraint(equalTo: layer.widthAnchor)
        ])
    }

    func remove(layer: VisionStackLayer) {
        layers.removeAll {
            if $0 === layer {
                layer.removeFromSuperview()
                return true
            }
            return false
        }
    }

    func clear() {
        layers.forEach {
            $0.removeFromSuperview()
        }
        layers = []
    }
}
