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
        
        spacing = 10
        alignment = .center
        axis = .horizontal
        distribution = .fillProportionally
        
        let backgroundImage = Asset.Assets.lanesBg.image.resizableImage(
            withCapInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            resizingMode: .stretch
        )
        let background = UIImageView(image: backgroundImage)
        background.translatesAutoresizingMaskIntoConstraints = false
        addSubview(background)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor, constant: -verticalInset),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: verticalInset),
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -horizontalInset),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: horizontalInset)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ description: RoadDescription) {
        removeAllArrangedSubviews()
        
        for (index, lane) in description.lanes.enumerated() {
            
            let leftMarkingView = UIImageView(image: lane.leftMarking.type.image)
            if description.lanes.first == lane, lane.leftMarking.type == .roadEdge {
                leftMarkingView.transform = CGAffineTransform(scaleX: -1, y: 1);
            }
            addArrangedSubview(leftMarkingView)
            
            if index == description.currentLane {
                let view = UIImageView(image: Asset.Assets.yourDirection.image)
                yourDirectionImageView = view
                addArrangedSubview(view)
            } else  {
                addArrangedSubview(lane.direction.view)
            }
            
            if description.lanes.last == lane {
                addArrangedSubview(UIImageView(image: lane.rightMarking.type.image))
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageX = yourDirectionImageView?.center.x else { return }
        
        let centerX = self.bounds.size.width / 2
        let offset = centerX - imageX
        
        transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    private func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
        yourDirectionImageView = nil
    }
}

private extension LaneMarkingType {
    var image: UIImage {
        let image: UIImage
        switch self {
        case .roadEdge:
            image = Asset.Assets.rightCurb.image
        case .solid:
            image = Asset.Assets.lanesLine.image
        case .doubleSolid:
            image = Asset.Assets.separatorDoubleLane.image
        case .dashed:
            image = Asset.Assets.halfLane.image
        case .unknown:
            image = Asset.Assets.questionMark.image
        }
        return image
    }
}

private extension LaneDirection {
    var view: UIImageView {
        let view: UIImageView
        switch self {
        case .backward:
            view = UIImageView(image: Asset.Assets.direction.image)
        case .forward:
            view = UIImageView(image: Asset.Assets.direction.image)
            view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        case .reverse:
            view = UIImageView(image: Asset.Assets.arrowReversed.image)
        }
        return view
    }
}
