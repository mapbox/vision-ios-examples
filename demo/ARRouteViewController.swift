//
// Created by Alexander Pristavko on 7/10/18.
// Copyright (c) 2018 Mapbox. All rights reserved.
//

import UIKit

private let specialTouchRect = CGRect(x: 0, y: 0, width: 70, height: 70)

protocol ARRoutePresenter {
    func presentIPQuery(initial: String?, completion: @escaping (String) -> Void)
}

final class ARRouteViewController: UIViewController {
    weak var interactor: ARRouteInteractable?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.activate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor?.deactivate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ipQueryTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ipQueryTapGesture))
        view.addGestureRecognizer(ipQueryTapRecognizer)
        
        let debugOverlayTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(debugOverlayTagGesture))
        view.addGestureRecognizer(debugOverlayTapRecognizer)
    }
    
    @objc private func ipQueryTapGesture(_ gestureRecognizer: UIGestureRecognizer) {
        guard gestureRecognizer.state == .ended else { return }
        
        var ipRect = specialTouchRect
        ipRect.origin.x = view.bounds.width - specialTouchRect.width
        let isSpecialTouch = ipRect.contains(gestureRecognizer.location(in: view))
        if isSpecialTouch {
            interactor?.ipQueried()
        }
    }
    
    @objc private func debugOverlayTagGesture(_ gestureRecognizer: UIGestureRecognizer) {
        guard gestureRecognizer.state == .ended else { return }
        
        var debugRect = specialTouchRect
        debugRect.origin.x = view.bounds.width - specialTouchRect.width
        debugRect.origin.y = view.bounds.height - specialTouchRect.height
        let isSpecialTouch = debugRect.contains(gestureRecognizer.location(in: view))
        if isSpecialTouch {
            interactor?.toggleDebugOverlay()
        }
    }
}

extension ARRouteViewController: ARRoutePresenter {
    func presentIPQuery(initial: String?, completion: @escaping (String) -> Void) {
        let alert = ValidatedInputAlertController(title: "Broadcasting",
                message: "Enter ip address of broadcasting server",
                preferredStyle: .alert)
        alert.setup(initial)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            guard let ip = alert.input else { return }
            completion(ip)
        }))
        alert.validation = { string in
            return string.components(separatedBy: ".").compactMap(Int.init).count == 4
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.show(alert, sender: self)
        }
    }
}
