//
//  RoadLanesView.swift
//  cv-assist-ios
//
//  Created by Maksim Vaniukevich on 7/11/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit
import MapboxVision

final class RoadLanesView: UIView {
    
    private let verticalInset: CGFloat = 9
    private let horizontalInset: CGFloat = 9
    
    private let stackView = UIStackView()
    private var yourDirectionImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.spacing = horizontalInset
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        let backgroundImage = Asset.Assets.lanesBg.image.resizableImage(
            withCapInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            resizingMode: .stretch
        )
        let background = UIImageView(image: backgroundImage)
        background.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: verticalInset),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalInset),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalInset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalInset)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ description: RoadDescription) {
        removeAllArrangedSubviews()

        for (index, lane) in description.lanes.enumerated() {
            
            let leftMarkingView = UIImageView(image: lane.leftEdge.type.image)
            if description.lanes.first == lane, lane.leftEdge.type == .curb {
                leftMarkingView.transform = CGAffineTransform(scaleX: -1, y: 1);
            }
            stackView.addArrangedSubview(leftMarkingView)

            if index == description.currentLaneIndex {
                let view = UIImageView(image: Asset.Assets.yourDirection.image)
                yourDirectionImageView = view
                stackView.addArrangedSubview(view)
            } else  {
                stackView.addArrangedSubview(lane.direction.view)
            }

            if description.lanes.last == lane {
                stackView.addArrangedSubview(UIImageView(image: lane.rightEdge.type.image))
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let imageX = yourDirectionImageView?.center.x else { return }
        
        let centerX = stackView.bounds.size.width / 2
        let offset = centerX - imageX
        
        transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    private func removeAllArrangedSubviews() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        yourDirectionImageView = nil
    }
}

private extension LaneEdgeType {
    var image: UIImage {
        let image: UIImage
        switch self {
        case .curb:
            image = Asset.Assets.rightCurb.image
        case .markupSolid:
            image = Asset.Assets.lanesLine.image
        case .markupDoubleSolid:
            image = Asset.Assets.separatorDoubleLane.image
        case .markupDashed:
            image = Asset.Assets.halfLane.image
        case .unknown:
            image = Asset.Assets.questionMark.image
        case .construction:
            image = UIImage()
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
        case .unkwnown:
            view = UIImageView()
        }
        return view
    }
}
