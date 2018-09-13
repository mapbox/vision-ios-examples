//
//  PaddedLabel.swift
//  cv-assist-ios
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
        let textRect = UIEdgeInsetsInsetRect(rect, insets)
        super.drawText(in: textRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += insets.left + insets.right
        contentSize.height += insets.top + insets.bottom
        return contentSize
    }
}
