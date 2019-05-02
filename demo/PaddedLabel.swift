//
//  Created by Alexander Pristavko on 4/12/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//


import Foundation
import UIKit

final class PaddedLabel: UILabel {
    private let insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
    }
    
    convenience override init(frame: CGRect) {
        self.init(insets: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let textRect = rect.inset(by: insets)
        super.drawText(in: textRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += insets.left + insets.right
        contentSize.height += insets.top + insets.bottom
        return contentSize
    }
}

extension PaddedLabel {
    private static let insets = UIEdgeInsets(top: 5, left: 10, bottom: 4, right: 10)
    
    static func createDarkRounded() -> PaddedLabel {
        let label = PaddedLabel(insets: insets)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0, alpha: 0.25)
        label.layer.cornerRadius = 14
        label.layer.masksToBounds = true
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.isHidden = true
        return label
    }
}
