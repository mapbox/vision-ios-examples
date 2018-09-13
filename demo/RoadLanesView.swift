//
//  RoadLanesView.swift
//  cv-assist-ios
//
//  Created by Maksim Vaniukevich on 7/11/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit
import MapboxVision

final class RoadLanesView: UIStackView {
    
    private let laneHeight: CGFloat = 25
    private let verticalInset: CGFloat = 10
    private let horizontalInset: CGFloat = 20
    
    private var yourDirectionImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.spacing = 10
        self.alignment = .center
        self.axis = .horizontal
        self.distribution = .fillProportionally
        
        let backgroundImage = Asset.Assets.lanesBg.image.resizableImage(
            withCapInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            resizingMode: .stretch
        )
        let background = UIImageView(image: backgroundImage)
        background.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(background)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.topAnchor, constant: -verticalInset),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: verticalInset),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -horizontalInset),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: horizontalInset)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ description: RoadDescription) {
        removeAllArrangedSubviews()
        
        for (index, lane) in description.lanes.enumerated() {
            
            if let leftMarking = lane.leftMarking.type.view {
                addArrangedSubview(leftMarking)
            }
            
            if index == description.currentLane {
                let view = UIImageView(image: Asset.Assets.yourDirection.image)
                yourDirectionImageView = view
                addArrangedSubview(view)
            } else if let direction = lane.direction.view {
                addArrangedSubview(direction)
            }
            
            if let last = description.lanes.last, last == lane,
               let rightMarking = lane.rightMarking.type.view {
                addArrangedSubview(rightMarking)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageX = yourDirectionImageView?.center.x else { return }
        
        let centerX = self.bounds.size.width / 2
        let offset = centerX - imageX
        
        self.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    private func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        removedSubviews.forEach({ $0.removeFromSuperview() })
        
        yourDirectionImageView = nil
    }
}

private extension LaneMarkingType {
    var view: UIImageView? {
        let view: UIImageView
        switch self {
        case .solid, .curb:
            view = UIImageView(image: Asset.Assets.lanesLine.image)
        case .doubleSolid:
            assertionFailure("Could not support double solid lane marking")
            return nil
        case .dashed:
            view = UIImageView(image: Asset.Assets.halfLane.image)
        case .unknown:
            view = UIImageView(image: Asset.Assets.questionMark.image)
        }
        return view
    }
}

private extension LaneDirection {
    var view: UIImageView? {
        let view: UIImageView
        switch self {
        case .backward:
            view = UIImageView(image: Asset.Assets.direction.image)
        case .forward:
            view = UIImageView(image: Asset.Assets.direction.image)
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        case .reverse:
            assertionFailure("Could not support reverse lines")
            return nil
        }
        return view
    }
}
