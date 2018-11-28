//
//  ImageSwitchingView.swift
//  demo
//
//  Created by Alexander Pristavko on 11/21/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit

private let translationDuration: TimeInterval = 0.5
private let fadeDuration: TimeInterval = 0.3
private let timing = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.25, y: 0.1),
                                             controlPoint2: CGPoint(x: 0.25, y: 1))

final class ImageSwitchingView: UIView {
    
    var image: UIImage? {
        get {
            return (stack.arrangedSubviews.first as? UIImageView)?.image
        }
        set {
            (stack.arrangedSubviews.first as? UIImageView)?.image = newValue
        }
    }

    var spacing: CGFloat {
        get {
            return stack.spacing
        }
        set {
            stack.spacing = newValue
        }
    }
    
    private let stack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalTo: stack.heightAnchor),
            widthAnchor.constraint(equalTo: stack.widthAnchor),
        ])
    }
    
    func `switch`(to image: UIImage) {
        let newView = UIImageView(image: image)
        let oldView = stack.arrangedSubviews.last
        
        stack.insertArrangedSubview(newView, at: 0)
        
        let diff = newView.frame.height + stack.spacing
        stack.transform = CGAffineTransform(translationX: 0, y: -diff)
        
        let group = DispatchGroup()
        
        group.enter()
        let transformAnimation = {
            self.stack.transform = .identity
        }
        let transformAnimator = UIViewPropertyAnimator(
            duration: translationDuration,
            timingParameters: timing,
            animation: transformAnimation,
            completion: group.leave
        )
        transformAnimator.startAnimation()
        
        if let oldView = oldView {
            group.enter()
            let fadeAnimation = {
                oldView.alpha = 0
                oldView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }
            let fadeAnimator = UIViewPropertyAnimator(
                duration: fadeDuration,
                timingParameters: timing,
                animation: fadeAnimation,
                completion: group.leave
            )
            fadeAnimator.startAnimation()
        }
        
        group.notify(queue: .main) {
            self.stack.arrangedSubviews.suffix(from: 1).forEach { $0.removeFromSuperview() }
        }
    }
    
    func reset() {
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

private extension UIViewPropertyAnimator {
    convenience init(duration: TimeInterval, timingParameters: UITimingCurveProvider, animation: @escaping () -> Void, completion: (() -> Void)?) {
        self.init(duration: duration, timingParameters: timingParameters)
        addAnimations(animation)
        if let completion = completion {
            addCompletion { _ in completion() }
        }
    }
}
