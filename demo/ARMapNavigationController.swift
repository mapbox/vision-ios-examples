//
//  ARMapNavigationController.swift
//  cv-assist-ios
//
//  Created by Alexander Pristavko on 3/20/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

private let routeEdgeInsets = UIEdgeInsets(top: 100, left: 200, bottom: 100, right: 200)
private let inset: CGFloat = 18.0

class ARMapNavigationController: UIViewController {
    
    var completion: ((Route) -> Void)?
    
    private var mapView: NavigationMapView {
        return view as! NavigationMapView
    }
    
    private var selectedRoute: Route?
    
    override func loadView() {
        let view = NavigationMapView(frame: .zero, styleURL: MGLStyle.darkStyleURL)
        view.delegate = self
        view.showsUserLocation = true
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(selectPlace)))
        
        view.addSubview(goButton)
        NSLayoutConstraint.activate([
            goButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            goButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            goButton.heightAnchor.constraint(equalToConstant: 44),
            goButton.widthAnchor.constraint(equalToConstant: 90),
        ])
        
        view.addSubview(hintLabel)
        NSLayoutConstraint.activate([
            hintLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            hintLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            hintLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.removeRoutes()
        hintLabel.isHidden = false
        goButton.isEnabled = false
    }
    
    private let goButton: UIButton = {
       let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.setTitle("Go", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        let color = UIColor(white: 0, alpha: 0.85)
        button.setBackgroundColor(color, for: .normal)
        button.setBackgroundColor(color.withAlphaComponent(0.35), for: .disabled)
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(goTapped), for: .touchUpInside)
        return button
    }()
    
    private let hintLabel: UILabel = {
        let label = PaddedLabel.createDarkRounded()
        label.text = "Tap on the map to select a destination"
        label.backgroundColor = UIColor(white: 0, alpha: 0.85)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.layer.cornerRadius = 22
        label.isHidden = false
        return label
    }()
    
    private let directions = Directions(accessToken: nil)
    
    @objc private func selectPlace(sender: UIGestureRecognizer) {
        guard sender.state == .began else { return }
        
        goButton.isEnabled = false
        hintLabel.isHidden = false
        
        guard let origin = mapView.userLocation?.coordinate else { return }
        let destination = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
        
        let options = NavigationRouteOptions(coordinates: [origin, destination], profileIdentifier: .automobile)
        
        directions.calculate(options) { [weak self] (_, routes, error) in
            guard let `self` = self, error == nil, let route = routes?.first else { return }
            
            self.goButton.isEnabled = true
            self.hintLabel.isHidden = true
            self.mapView.showRoutes([route])
            
            self.mapView.setVisibleCoordinateBounds(route.polyline.overlayBounds, edgePadding: routeEdgeInsets, animated: true)
            
            self.selectedRoute = route
        }
    }
    
    @objc private func goTapped() {
        guard let route = selectedRoute else { return }
        completion?(route)
    }
    
    private var isLocationSet = false
}

extension ARMapNavigationController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        guard !isLocationSet, let location = userLocation else { return }
        
        mapView.setCenter(location.coordinate, zoomLevel: 12, animated: true)
        isLocationSet = true
    }
}

extension Route {
    var polyline: MGLPolyline {
        var coordinates = self.coordinates!
        return MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
    }
}
