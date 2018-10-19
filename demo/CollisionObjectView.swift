//
//  CollisionObjectView.swift
//  demo
//
//  Created by Maksim on 10/19/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import UIKit

final class CollisionObjectView: UIView {
    
    private let imageView = UIImageView(image: Asset.Assets.alert.image)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ frame: CGRect) {
        self.frame = frame
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [UIColor(red: 1.0, green: 0, blue: 55/255.0, alpha: 1.0).cgColor, UIColor.clear.cgColor] as CFArray
        let endRadius = min(frame.width, frame.height) * 0.5
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil) else { return }
        
        context.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        context.restoreGState()
    }
}
