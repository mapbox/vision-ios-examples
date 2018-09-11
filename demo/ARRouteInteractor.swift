//
// Created by Alexander Pristavko on 7/10/18.
// Copyright (c) 2018 Mapbox. All rights reserved.
//

import Foundation

protocol Interactable: class {
    func activate()
    func deactivate()
    var isActivated: Bool { get }
}

protocol ARRouteInteractable: Interactable {
    func ipQueried()
    func toggleDebugOverlay()
}

final class ARRouteInteractor: ARRouteInteractable {
    weak var containerDelegate: ContainerDelegate?
    
    private let presenter: ARRoutePresenter
    private let broadcastService = BroadcastService()
    
    private(set) var isActivated: Bool = false
    
    init(presenter: ARRoutePresenter) {
        self.presenter = presenter
        broadcastService.delegate = self
    }
    
    func ipQueried() {
        presentIPQuery()
    }
    
    func toggleDebugOverlay() {
        //containerDelegate?.toggleDebugOverlay()
    }
    
    func activate() {
        isActivated = true
        let successfulStart = broadcastService.start()
        if !successfulStart {
            presentIPQuery()
        }
    }
    
    func deactivate() {
        isActivated = false
        broadcastService.stop()
    }
    
    private func presentIPQuery() {
        presenter.presentIPQuery(initial: broadcastService.ipAddress) { [weak self] ip in
            self?.broadcastService.ipAddress = ip
            self?.broadcastService.start()
        }
    }
}

extension ARRouteInteractor: BroadcastingDelegate {
    func startReceived(timestamp: String) {
        //containerDelegate?.startBroadcasting(at: timestamp)
    }
}
