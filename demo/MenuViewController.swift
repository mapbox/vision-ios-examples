//
//  MenuViewController.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit

final class MenuViewController: UIViewController {
    
    weak var delegate: MenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        let titleView = UIImageView(image: UIImage(named: "Title"))
        titleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),
        ])
        
        let centerLine = UIImageView(image: UIImage(named: "Line-center"))
        centerLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(centerLine)
        NSLayoutConstraint.activate([
            centerLine.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            centerLine.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 18)
        ])
        
        let leftLine = UIImageView(image: UIImage(named: "Line-left-right"))
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(leftLine)
        NSLayoutConstraint.activate([
            leftLine.centerYAnchor.constraint(equalTo: centerLine.centerYAnchor),
            leftLine.trailingAnchor.constraint(equalTo: centerLine.leadingAnchor)
        ])
        
        let rightLine = UIImageView(image: UIImage(named: "Line-left-right"))
        rightLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rightLine)
        NSLayoutConstraint.activate([
            rightLine.centerYAnchor.constraint(equalTo: centerLine.centerYAnchor),
            rightLine.leadingAnchor.constraint(equalTo: centerLine.trailingAnchor)
        ])
        
        let topFirstLine = UIImageView(image: UIImage(named: "Line-top-bottom"))
        topFirstLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topFirstLine)
        NSLayoutConstraint.activate([
            topFirstLine.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            topFirstLine.leadingAnchor.constraint(equalTo: centerLine.leadingAnchor)
        ])
        
        let topSecondLine = UIImageView(image: UIImage(named: "Line-top-bottom"))
        topSecondLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topSecondLine)
        NSLayoutConstraint.activate([
            topSecondLine.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            topSecondLine.trailingAnchor.constraint(equalTo: centerLine.trailingAnchor)
        ])
        
        let bottomFirstLine = UIImageView(image: UIImage(named: "Line-top-bottom"))
        bottomFirstLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        bottomFirstLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomFirstLine)
        NSLayoutConstraint.activate([
            bottomFirstLine.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            bottomFirstLine.leadingAnchor.constraint(equalTo: centerLine.leadingAnchor)
        ])
        
        let bottomSecondLine = UIImageView(image: UIImage(named: "Line-top-bottom"))
        bottomSecondLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        bottomSecondLine.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomSecondLine)
        NSLayoutConstraint.activate([
            bottomSecondLine.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            bottomSecondLine.trailingAnchor.constraint(equalTo: centerLine.trailingAnchor)
        ])
        
        signsDetectionButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        self.view.addSubview(signsDetectionButton)
        NSLayoutConstraint.activate([
            signsDetectionButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            signsDetectionButton.trailingAnchor.constraint(equalTo: centerLine.leadingAnchor),
            signsDetectionButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            signsDetectionButton.heightAnchor.constraint(equalToConstant: MenuViewController.buttonHeight)
        ])
        signsDetectionButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        segmentationButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        self.view.addSubview(segmentationButton)
        NSLayoutConstraint.activate([
            segmentationButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            segmentationButton.centerXAnchor.constraint(equalTo: centerLine.centerXAnchor),
            segmentationButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor),
            segmentationButton.heightAnchor.constraint(equalToConstant: MenuViewController.buttonHeight)
        ])
        segmentationButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        distanceToObjectButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        self.view.addSubview(distanceToObjectButton)
        NSLayoutConstraint.activate([
            distanceToObjectButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            distanceToObjectButton.trailingAnchor.constraint(equalTo: bottomFirstLine.leadingAnchor),
            distanceToObjectButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            distanceToObjectButton.heightAnchor.constraint(equalToConstant: MenuViewController.buttonHeight)
        ])
        distanceToObjectButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        objectDetectorButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        self.view.addSubview(objectDetectorButton)
        NSLayoutConstraint.activate([
            objectDetectorButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            objectDetectorButton.leadingAnchor.constraint(equalTo: centerLine.trailingAnchor),
            objectDetectorButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            objectDetectorButton.heightAnchor.constraint(equalToConstant: MenuViewController.buttonHeight)
        ])
        objectDetectorButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        objectMappingButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        self.view.addSubview(objectMappingButton)
        NSLayoutConstraint.activate([
            objectMappingButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            objectMappingButton.leadingAnchor.constraint(equalTo: bottomFirstLine.leadingAnchor),
            objectMappingButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            objectMappingButton.heightAnchor.constraint(equalToConstant: MenuViewController.buttonHeight)
        ])
        objectMappingButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        laneDetectionButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        self.view.addSubview(laneDetectionButton)
        NSLayoutConstraint.activate([
            laneDetectionButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            laneDetectionButton.leadingAnchor.constraint(equalTo: bottomSecondLine.leadingAnchor),
            laneDetectionButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            laneDetectionButton.heightAnchor.constraint(equalToConstant: MenuViewController.buttonHeight)
        ])
        laneDetectionButton.centerVertically(padding: MenuViewController.buttonPadding)
    }
    
    @objc private func selected(_ sender: UIButton) {
        switch sender {
        case segmentationButton: delegate?.selected(screen: .segmentation)
        case laneDetectionButton: delegate?.selected(screen: .laneDetection)
        case distanceToObjectButton: delegate?.selected(screen: .distanceToObject)
        case signsDetectionButton: delegate?.selected(screen: .signsDetection)
        case objectDetectorButton: delegate?.selected(screen: .objectDetector)
        case objectMappingButton: delegate?.selected(screen: .map)
        default: assertionFailure("Couldn't support this kind of button")
        }
    }
    
    private let segmentationButton = UIButton.createMenuButton(for: .segmentation)
    private let laneDetectionButton = UIButton.createMenuButton(for: .laneDetection)
    private let distanceToObjectButton = UIButton.createMenuButton(for: .distanceToObject)
    private let signsDetectionButton = UIButton.createMenuButton(for: .signsDetection)
    private let objectDetectorButton = UIButton.createMenuButton(for: .objectDetector)
    private let objectMappingButton = UIButton.createMenuButton(for: .map)

    private static let buttonPadding: CGFloat = 14.0
    private static let buttonHeight: CGFloat = 147.0
}

extension Screen {
    
    var title: String {
        switch self {
        case .segmentation:
            return "Segmentation"
        case .laneDetection:
            return "Lane detection"
        case .distanceToObject:
            return "Distance to Object"
        case .signsDetection:
            return "Sign Detection"
        case .objectDetector:
            return "Object Detection"
        case .map:
            return "Object Mapping"
        }
    }
    
    var iconName: String {
        switch self {
        case .segmentation:
            return "icon1"
        case .laneDetection:
            return "icon2"
        case .distanceToObject:
            return "icon3"
        case .signsDetection:
            return "icon4"
        case .objectDetector:
            return "icon6"
        case .map:
            return "icon5"
        }
    }
}

private extension UIButton {
    
    static func createMenuButton(for screen: Screen) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(screen.title, for: .normal)
        button.setImage(UIImage(named: screen.iconName), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 16)
        return button
    }
    
    func centerVertically(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 30.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
}
