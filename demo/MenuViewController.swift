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
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        let lineTopBottomImage = Asset.Assets.lineTopBottom.image
        let lineLeftRightImage = Asset.Assets.lineLeftRight.image
        let lineCenterImage = Asset.Assets.lineCenter.image
        
        let titleView = UIImageView(image: Asset.Assets.title.image)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),
        ])
        
        let centerLine = UIImageView(image: lineCenterImage)
        centerLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerLine)
        NSLayoutConstraint.activate([
            centerLine.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            centerLine.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: 18),
            centerLine.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
        ])
        
        let leftLine = UIImageView(image: lineLeftRightImage)
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftLine)
        NSLayoutConstraint.activate([
            leftLine.centerYAnchor.constraint(equalTo: centerLine.centerYAnchor),
            leftLine.trailingAnchor.constraint(equalTo: centerLine.leadingAnchor),
            leftLine.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25)
        ])
        
        let rightLine = UIImageView(image: lineLeftRightImage)
        rightLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightLine)
        NSLayoutConstraint.activate([
            rightLine.centerYAnchor.constraint(equalTo: centerLine.centerYAnchor),
            rightLine.leadingAnchor.constraint(equalTo: centerLine.trailingAnchor),
            rightLine.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25)
        ])
        
        let topFirstLine = UIImageView(image: lineTopBottomImage)
        topFirstLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topFirstLine)
        NSLayoutConstraint.activate([
            topFirstLine.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            topFirstLine.leadingAnchor.constraint(equalTo: centerLine.leadingAnchor)
        ])
        
        let topSecondLine = UIImageView(image: lineTopBottomImage)
        topSecondLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topSecondLine)
        NSLayoutConstraint.activate([
            topSecondLine.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            topSecondLine.trailingAnchor.constraint(equalTo: centerLine.centerXAnchor)
        ])
        
        let topThirdLine = UIImageView(image: lineTopBottomImage)
        topThirdLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topThirdLine)
        NSLayoutConstraint.activate([
            topThirdLine.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            topThirdLine.trailingAnchor.constraint(equalTo: centerLine.trailingAnchor)
        ])
        
        signsDetectionButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        view.addSubview(signsDetectionButton)
        NSLayoutConstraint.activate([
            signsDetectionButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            signsDetectionButton.trailingAnchor.constraint(equalTo: centerLine.leadingAnchor),
            signsDetectionButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            signsDetectionButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        signsDetectionButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        segmentationButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        view.addSubview(segmentationButton)
        NSLayoutConstraint.activate([
            segmentationButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            segmentationButton.leadingAnchor.constraint(equalTo: topFirstLine.leadingAnchor),
            segmentationButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            segmentationButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        segmentationButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        objectDetectorButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        view.addSubview(objectDetectorButton)
        NSLayoutConstraint.activate([
            objectDetectorButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            objectDetectorButton.leadingAnchor.constraint(equalTo: topSecondLine.leadingAnchor),
            objectDetectorButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            objectDetectorButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        objectDetectorButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        arRoutingButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        view.addSubview(arRoutingButton)
        NSLayoutConstraint.activate([
            arRoutingButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            arRoutingButton.centerXAnchor.constraint(equalTo: centerLine.centerXAnchor),
            arRoutingButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            arRoutingButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        arRoutingButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        let bottomFirstLine = UIImageView(image: lineTopBottomImage)
        bottomFirstLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        bottomFirstLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomFirstLine)
        NSLayoutConstraint.activate([
            bottomFirstLine.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            bottomFirstLine.leadingAnchor.constraint(equalTo: arRoutingButton.leadingAnchor)
        ])
        
        let bottomSecondLine = UIImageView(image: lineTopBottomImage)
        bottomSecondLine.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        bottomSecondLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSecondLine)
        NSLayoutConstraint.activate([
            bottomSecondLine.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            bottomSecondLine.trailingAnchor.constraint(equalTo: arRoutingButton.trailingAnchor)
        ])
        
        distanceToObjectButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        view.addSubview(distanceToObjectButton)
        NSLayoutConstraint.activate([
            distanceToObjectButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            distanceToObjectButton.trailingAnchor.constraint(equalTo: bottomFirstLine.leadingAnchor),
            distanceToObjectButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            distanceToObjectButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        distanceToObjectButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        objectMappingButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        view.addSubview(objectMappingButton)
        NSLayoutConstraint.activate([
            objectMappingButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            objectMappingButton.leadingAnchor.constraint(equalTo: topThirdLine.leadingAnchor),
            objectMappingButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            objectMappingButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        objectMappingButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        laneDetectionButton.addTarget(self, action: #selector(selected), for: .touchUpInside)
        view.addSubview(laneDetectionButton)
        NSLayoutConstraint.activate([
            laneDetectionButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            laneDetectionButton.leadingAnchor.constraint(equalTo: bottomSecondLine.leadingAnchor),
            laneDetectionButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            laneDetectionButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        laneDetectionButton.centerVertically(padding: MenuViewController.buttonPadding)
        
        view.addSubview(infoButton)
        NSLayoutConstraint.activate([
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MenuViewController.infoButtonPadding),
            infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: MenuViewController.infoButtonPadding),
        ])
    }
    
    @objc private func selected(_ sender: UIButton) {
        switch sender {
        case segmentationButton: delegate?.selected(screen: .segmentation)
        case laneDetectionButton: delegate?.selected(screen: .laneDetection)
        case distanceToObjectButton: delegate?.selected(screen: .distanceToObject)
        case signsDetectionButton: delegate?.selected(screen: .signsDetection)
        case objectDetectorButton: delegate?.selected(screen: .objectDetection)
        case objectMappingButton: delegate?.selected(screen: .map)
        case arRoutingButton: delegate?.selected(screen: .arRouting)
        default: assertionFailure("Couldn't support this kind of button")
        }
    }
    
    @objc private func infoTapped() {
        let previewController = LicenseController.previewController()
        previewController.delegate = self
        previewController.presentPreview(animated: true)
    }
    
    private let segmentationButton = UIButton.createMenuButton(for: .segmentation)
    private let laneDetectionButton = UIButton.createMenuButton(for: .laneDetection)
    private let distanceToObjectButton = UIButton.createMenuButton(for: .distanceToObject)
    private let signsDetectionButton = UIButton.createMenuButton(for: .signsDetection)
    private let objectDetectorButton = UIButton.createMenuButton(for: .objectDetection)
    private let objectMappingButton = UIButton.createMenuButton(for: .map)
    private let arRoutingButton = UIButton.createMenuButton(for: .arRouting)
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
        button.tintColor = UIColor(white: 0.5, alpha: 0.5)
        return button
    }()

    private static let buttonPadding: CGFloat = 14.0
    private static let cellHeight: CGFloat = 147.0
    private static let cellWidth: CGFloat = 180.0
    private static let infoButtonPadding: CGFloat = 20
}

extension MenuViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
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
        case .objectDetection:
            return "Object Detection"
        case .map:
            return "Object Mapping"
        case .arRouting:
            return "AR Routing"
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .segmentation:
            return Asset.Assets.icon1.image
        case .laneDetection:
            return Asset.Assets.icon2.image
        case .distanceToObject:
            return Asset.Assets.icon3.image
        case .signsDetection:
            return Asset.Assets.icon4.image
        case .map:
            return Asset.Assets.icon5.image
        case .objectDetection:
            return Asset.Assets.icon6.image
        case .arRouting:
            return Asset.Assets.icon7.image
        }
    }
}

private extension UIButton {
    
    static func createMenuButton(for screen: Screen) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(screen.title, for: .normal)
        button.setImage(screen.iconImage, for: .normal)
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
