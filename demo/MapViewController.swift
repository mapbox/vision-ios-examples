//
//  MapViewController.swift
//  demo
//
//  Created by Alexander Pristavko on 8/10/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import UIKit
import Mapbox

private let styleURL = URL(string: "mapbox://styles/willwhite/cjkmusatv0rox2roea7dz7r1p")

final class MapViewController: UIViewController, MGLMapViewDelegate {
    
    override func viewDidLoad() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        guard let center = userLocation?.location else { return }
        mapView.setCenter(center.coordinate, zoomLevel: 15, animated: false)
    }
    
    private let mapView: MGLMapView = {
        let view = MGLMapView(frame: CGRect.zero, styleURL: styleURL)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsUserLocation = true
        view.backgroundColor = .black
        return view
    }()
}
