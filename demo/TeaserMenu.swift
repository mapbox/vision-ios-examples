import UIKit

struct TeaserMenuItem {
    let name: String
    let icon: UIImage
    let activateBlock: (ARControlStack)->Void
}

class TeaserMenu: StackLevel {
    init(with menuItems: [TeaserMenuItem]) {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func didChoose(menuItem: (TeaserMenuItem) -> Void) {

    }
}
