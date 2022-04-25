
import Foundation

enum CurrentUser {
    static var value: Bool {
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.bool.rawValue) }
        get { (UserDefaults.standard.bool(forKey: Keys.bool.rawValue)) }
    }
}
