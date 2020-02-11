import UIKit

class VisionStackLevel: UIView {
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
        for subview in subviews {
            if subview.frame.contains(point) {
                return subview.hitTest(convert(point, to: subview), with: event)
            }
        }
        return nil
    }
}
