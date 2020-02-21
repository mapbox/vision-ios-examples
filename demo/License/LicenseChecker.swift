import Foundation
import UIKit

private let licenseCheckKey = "licenseCheckKey"

struct LicenseController {
    private init() {}

    static func checkSubmission() -> Bool {
        UserDefaults.standard.bool(forKey: licenseCheckKey)
    }

    static func submit() {
        UserDefaults.standard.setValue(true, forKey: licenseCheckKey)
    }
}
