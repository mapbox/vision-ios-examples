//
//  ContainerViewController.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit
import CoreLocation
import VisionSDK

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
    
    private weak var currentViewController: UIViewController?
}

extension ContainerViewController: ContainerPresenter {
    
    func presentSegmentation() {
        visionViewController?.frameVisualizationMode = .segmentation
    }
    
    func presentObjectDetection() {
        visionViewController?.frameVisualizationMode = .detection
    }
    
    func presentDistanceToObject() {
        visionViewController?.frameVisualizationMode = .clear
    }
    
    func presentSignDetection() {
        visionViewController?.frameVisualizationMode = .clear
    }
    
    func presentLaneDetection() {
        visionViewController?.frameVisualizationMode = .clear
    }
    
    func presentMenu() {
        guard let viewController = menuViewController else {
            assertionFailure("Menu should be initialized before presenting")
            return
        }
        present(viewController: viewController)
    }
    
    func presentVision() {
        guard let viewController = visionViewController else {
            assertionFailure("Vision should be initialized before presenting")
            return
        }
        present(viewController: viewController)
        viewController.frameVisualizationMode = .clear
    }
    
    func presentMap(center: CLLocation) {
        let viewController = MapViewController()
        viewController.center = center
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
        currentViewController = nil
    }
    
    func dismissCurrent() {
        guard let viewController = currentViewController else { return }
        dismiss(viewController: viewController)
    }
}

