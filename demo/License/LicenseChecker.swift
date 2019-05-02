//
//  Created by Alexander Pristavko on 9/28/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import UIKit

private let licenseCheckKey = "licenseCheckKey"

struct LicenseController {
    private init() {}
    
    static func checkSubmission() -> Bool {
        return UserDefaults.standard.bool(forKey: licenseCheckKey)
    }
    
    static func submit() {
        UserDefaults.standard.setValue(true, forKey: licenseCheckKey)
    }
    
    static func previewController() -> UIDocumentInteractionController {
        let path =  Bundle.main.path(forResource: "agreement", ofType: "pdf")!
        let previewController = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
        previewController.name = "Evaluation Agreement"
        return previewController
    }
}
