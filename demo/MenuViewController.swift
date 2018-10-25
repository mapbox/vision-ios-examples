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
        
        let select: (Screen) -> Void = { [weak self] screen in
            self?.delegate?.selected(screen: screen)
        }
        
        let segmentationButton = MenuItemButton(for: .segmentation, action: select)
        let laneDetectionButton = MenuItemButton(for: .laneDetection, action: select)
        let distanceToObjectButton = MenuItemButton(for: .distanceToObject, action: select)
        let signsDetectionButton = MenuItemButton(for: .signsDetection, action: select)
        let objectDetectorButton = MenuItemButton(for: .objectDetection, action: select)
        let objectMappingButton = MenuItemButton(for: .map, action: select)
        let arRoutingButton = MenuItemButton(for: .arRouting, action: select)
        
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
        
        view.addSubview(signsDetectionButton)
        NSLayoutConstraint.activate([
            signsDetectionButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            signsDetectionButton.trailingAnchor.constraint(equalTo: centerLine.leadingAnchor),
            signsDetectionButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            signsDetectionButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        
        view.addSubview(segmentationButton)
        NSLayoutConstraint.activate([
            segmentationButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            segmentationButton.leadingAnchor.constraint(equalTo: topFirstLine.leadingAnchor),
            segmentationButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            segmentationButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        
        view.addSubview(objectDetectorButton)
        NSLayoutConstraint.activate([
            objectDetectorButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            objectDetectorButton.leadingAnchor.constraint(equalTo: topSecondLine.leadingAnchor),
            objectDetectorButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            objectDetectorButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        
        view.addSubview(arRoutingButton)
        NSLayoutConstraint.activate([
            arRoutingButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            arRoutingButton.centerXAnchor.constraint(equalTo: centerLine.centerXAnchor),
            arRoutingButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            arRoutingButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        
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
        
        view.addSubview(distanceToObjectButton)
        NSLayoutConstraint.activate([
            distanceToObjectButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            distanceToObjectButton.trailingAnchor.constraint(equalTo: bottomFirstLine.leadingAnchor),
            distanceToObjectButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            distanceToObjectButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        
        view.addSubview(objectMappingButton)
        NSLayoutConstraint.activate([
            objectMappingButton.bottomAnchor.constraint(equalTo: centerLine.topAnchor),
            objectMappingButton.leadingAnchor.constraint(equalTo: topThirdLine.leadingAnchor),
            objectMappingButton.widthAnchor.constraint(equalTo: centerLine.widthAnchor, multiplier: 0.5),
            objectMappingButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        
        view.addSubview(laneDetectionButton)
        NSLayoutConstraint.activate([
            laneDetectionButton.topAnchor.constraint(equalTo: centerLine.bottomAnchor),
            laneDetectionButton.leadingAnchor.constraint(equalTo: bottomSecondLine.leadingAnchor),
            laneDetectionButton.widthAnchor.constraint(equalTo: leftLine.widthAnchor),
            laneDetectionButton.heightAnchor.constraint(equalToConstant: MenuViewController.cellHeight)
        ])
        
        view.addSubview(infoButton)
        NSLayoutConstraint.activate([
            infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MenuViewController.infoButtonPadding),
            infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: MenuViewController.infoButtonPadding),
        ])
    }
    
    @objc private func infoTapped() {
        let previewController = LicenseController.previewController()
        previewController.delegate = self
        previewController.presentPreview(animated: true)
    }
    
    private let infoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Asset.Assets.info.image, for: .normal)
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
            return L10n.menuSegmentationButton
        case .laneDetection:
            return L10n.menuLaneDetectionButton
        case .distanceToObject:
            return L10n.menuCollisionDetectionButton
        case .signsDetection:
            return L10n.menuSignDetectionButton
        case .objectDetection:
            return L10n.menuObjectDetectionButton
        case .map:
            return L10n.menuObjectMappingButton
        case .arRouting:
            return L10n.menuARButton
        case .menu:
            return L10n.menuTitle
        }
    }
    
    var iconImage: UIImage {
        switch self {
        case .segmentation:
            return Asset.Assets.icon1.image
        case .laneDetection:
            return Asset.Assets.icon2.image
        case .distanceToObject:
            return Asset.Assets.collisionDetection.image
        case .signsDetection:
            return Asset.Assets.icon4.image
        case .map:
            return Asset.Assets.icon5.image
        case .objectDetection:
            return Asset.Assets.icon6.image
        case .arRouting:
            return Asset.Assets.icon7.image
        case .menu:
            return UIImage()
        }
    }
}

private class MenuItemButton: UIView {
    
    private let padding: CGFloat = 8
    
    private let action: () -> Void
    
    init(for screen: Screen, action: @escaping (Screen) -> Void) {
        
        self.action = { action(screen) }
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -padding)
        ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding)
        ])
        
        titleLabel.text = screen.title
        imageView.image = screen.iconImage
        
        let gestureRecogrizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        addGestureRecognizer(gestureRecogrizer)
    }
    
    @objc func tap() {
        action()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Bold", size: 16)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
