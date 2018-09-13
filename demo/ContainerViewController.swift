//
//  ContainerViewController.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit
import MapboxVision

private let roadLanesTopInset: CGFloat = 18
private let roadLanesHeight: CGFloat = 64
private let smallRelativeInset: CGFloat = 16
private let buttonHeight: CGFloat = 36

final class ContainerViewController: UIViewController {
    
    weak var delegate: ContainerDelegate? {
        didSet {
            self.backButton.addTarget(delegate,
                                      action: #selector(ContainerDelegate.backButtonPressed),
                                      for: .touchUpInside)
        }
    }
    
    var visionViewController: VisionPresentationViewController?
    var menuViewController: MenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            backButton.widthAnchor.constraint(lessThanOrEqualToConstant: 44),
            backButton.heightAnchor.constraint(lessThanOrEqualToConstant: 44)
        ])
        
        view.addSubview(roadLanesView)
        NSLayoutConstraint.activate([
            roadLanesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roadLanesView.topAnchor.constraint(equalTo: view.topAnchor, constant: roadLanesTopInset),
            roadLanesView.heightAnchor.constraint(equalToConstant: roadLanesHeight)
        ])
        
        view.addSubview(signsStack)
        NSLayoutConstraint.activate([
            signsStack.topAnchor.constraint(equalTo: view.topAnchor),
            signsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(distanceView)
        
        view.addSubview(distanceLabel)
        NSLayoutConstraint.activate([
            distanceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -smallRelativeInset),
            distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])
    }
    
    private func present(viewController: UIViewController) {
        self.addChildViewController(viewController)
        self.view.insertSubview(viewController.view, belowSubview: self.backButton)
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
        viewController.didMove(toParentViewController: self)
    }
    
    private func dismiss(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }

    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        return button
    }()
    
    private let roadLanesView: RoadLanesView = {
        let view = RoadLanesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let signsStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = smallRelativeInset
        view.alignment = .center
        view.axis = .horizontal
        view.isHidden = true
        return view
    }()
    
    private let distanceView: DistanceView = {
        let view = DistanceView(frame: .zero)
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private let distanceLabel: PaddedLabel = {
        let view = PaddedLabel.createDarkRounded()
        view.textColor = UIColor(red: 0.29, green: 1, blue: 0.14 , alpha: 1)
        view.textColor = .white
        return view
    }()
    
    private lazy var distanceFormatter: DistanceFormatter = {
        return DistanceFormatter(approximate: false)
    }()
    
    private weak var currentViewController: UIViewController?
}

extension ContainerViewController: ContainerPresenter {
    
    func present(signs: [ImageAsset]) {
        signsStack.subviews.forEach { $0.removeFromSuperview() }
        signsStack.isHidden = false
        signs.map { UIImageView(image: $0.image) }.forEach(signsStack.addArrangedSubview)
    }
    
    func present(distanceToCar: DistanceToCar?, canvasSize: CGSize) {
        guard let distanceToCar = distanceToCar else {
            distanceView.isHidden = true
            distanceLabel.isHidden = true
            return
        }
        
        distanceView.isHidden = false
        distanceLabel.isHidden = false
        
        let left = distanceToCar.leftPosition.convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)
        let right = distanceToCar.rightPosition.convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)
        
        distanceView.update(left, right)
        distanceLabel.text = distanceFormatter.string(fromMeters: distanceToCar.distance)
    }
    
    func present(roadDescription: RoadDescription?) {
        guard let roadDescription = roadDescription else {
            roadLanesView.isHidden = true
            return
        }
        roadLanesView.isHidden = false
        roadLanesView.update(roadDescription)
    }
    
    func present(screen: Screen) {
        switch screen {
        case .signsDetection: visionViewController?.frameVisualizationMode = .clear
        case .segmentation: visionViewController?.frameVisualizationMode = .segmentation
        case .objectDetection: visionViewController?.frameVisualizationMode = .detection
        case .distanceToObject: visionViewController?.frameVisualizationMode = .clear
        case .map: presentMap()
        case .laneDetection: visionViewController?.frameVisualizationMode = .clear
        }
    }
    
    func presentMenu() {
        guard let viewController = menuViewController else {
            assertionFailure("Menu should be initialized before presenting")
            return
        }
        present(viewController: viewController)
        visionViewController?.frameVisualizationMode = .clear
    }
    
    func presentVision() {
        guard let viewController = visionViewController else {
            assertionFailure("Vision should be initialized before presenting")
            return
        }
        
        present(viewController: viewController)
        viewController.frameVisualizationMode = .clear
    }
    
    private func presentMap() {
        let viewController = MapViewController()
        present(viewController: viewController)
        currentViewController = viewController
    }

    func presentBackButton(isVisible: Bool) {
        backButton.isHidden = !isVisible
    }
    
    func dismissMenu() {
        guard let viewController = menuViewController else {
            assertionFailure("Menu should be initialized before dismiss")
            return
        }
        dismiss(viewController: viewController)
    }
    
    func dismissCurrent() {
        
        roadLanesView.isHidden = true
        signsStack.isHidden = true
        
        guard let viewController = currentViewController else { return }
        dismiss(viewController: viewController)
        currentViewController = nil
    }
}

private extension PaddedLabel {
    private static let insets = UIEdgeInsets(top: 5, left: 10, bottom: 4, right: 10)
    
    static func createDarkRounded() -> PaddedLabel {
        let label = PaddedLabel(insets: insets)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(white: 0, alpha: 0.25)
        label.layer.cornerRadius = 14
        label.layer.masksToBounds = true
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.isHidden = true
        return label
    }
}


