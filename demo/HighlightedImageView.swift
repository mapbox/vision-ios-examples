//
//  HighlightedImageView.swift
//  demo
//
//  Created by Alexander Pristavko on 10/31/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit

private let shadowSpread: CGFloat = -6
private let shadowRadius: CGFloat = 15

class HighlightedImageView: UIImageView {

    var highlightColor: UIColor = .clear {
        didSet {
            guard isHighlighted else { return }
            updateShadow()
        }
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            guard isHighlighted != newValue else { return }
            super.isHighlighted = newValue
            updateShadow()
        }
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
        layer.shadowRadius = shadowRadius
        
        updateShadow()
    }
    
    private func updateShadow() {
        layer.shadowColor = (isHighlighted ? highlightColor : UIColor.clear).cgColor
        updateShadowPath()
    }
    
    private func updateShadowPath() {
        var shadowPath: CGPath?
        if isHighlighted {
            let rect = bounds.insetBy(dx: shadowSpread, dy: shadowSpread)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
        layer.shadowPath = shadowPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }
}
