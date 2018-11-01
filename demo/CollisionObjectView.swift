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
    
    private var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        if let gradient = gradientLayer {
            gradient.backgroundColor = UIColor.clear.cgColor
            gradient.locations = [0.0, 0.75, 1.0]
            gradient.type = "radial"
            gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 1)
        }
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    var color: UIColor? {
        didSet {
            guard let color = color else { return }
            gradientLayer?.colors = [
                color.withAlphaComponent(0.64).cgColor,
                color.withAlphaComponent(0.45).cgColor,
                color.withAlphaComponent(0).cgColor
            ]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
