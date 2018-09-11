//
//  DistanceView.swift
//  cv-assist-ios
//
//  Created by Maksim Vaniukevich on 2/27/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import UIKit
import VisionCore

final class DistanceView: UIView {
    
    private static let height: CGFloat = 15
    private var colors: [CGFloat] = CollisionAlertState.notTriggered.colors
    
    func update(with objectDescription: ObjectDescription) {
        let isDistanceValid = distance.worldPos.y != -1
        isHidden = !isDistanceValid

        guard isDistanceValid, let superview = superview else { return }

        let right = CGPoint(x: distance.rightRelPos.x * superview.bounds.width, y: distance.rightRelPos.y * superview.bounds.height)
        let left = CGPoint(x: distance.leftRelPos.x * superview.bounds.width, y: distance.leftRelPos.y * superview.bounds.height)

        frame = CGRect(x: left.x, y: left.y, width: right.x - left.x, height: DistanceView.height)
        colors = distance.collisionAlertState.colors

        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.saveGState()

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let colorComponents = colors
        let locations: [CGFloat] = [0.0, 1.0]

        guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents, locations: locations, count: 2) else {
            return
        }

        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.origin.x + rect.size.height, y: rect.origin.y))
        path.addLine(to: CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height))
        path.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: rect.origin.y + rect.size.height))
        path.addLine(to: CGPoint(x: rect.origin.x + rect.size.width - rect.size.height, y: rect.origin.y))
        path.close()

        context.addPath(path.cgPath)
        context.clip()
        context.drawLinearGradient(gradient, start: rect.origin, end: CGPoint(x: rect.origin.x, y: rect.maxY), options: .drawsBeforeStartLocation)
        context.restoreGState()
    }
}
