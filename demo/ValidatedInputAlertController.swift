//
// Created by Alexander Pristavko on 7/10/18.
// Copyright (c) 2018 Mapbox. All rights reserved.
//

import UIKit

final class ValidatedInputAlertController: UIAlertController {
    var input: String? {
        get {
            return textFields?.first?.text
        }
        set {
            textFields?.first?.text = input
        }
    }
    
    var inputField: UITextField! {
        return textFields?.first!
    }
    
    var validation: ((String) -> Bool)? {
        didSet {
            guard let textField = textFields?.first else { return }
            textFieldDidChange(textField)
        }
    }
    
    func setup(_ initial: String?) {
        addTextField { textField in
            textField.text = initial
            textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            actions.first?.isEnabled = false
            return
        }
        guard let validation = validation else { return }
        
        actions.first?.isEnabled = validation(text)
    }
}
