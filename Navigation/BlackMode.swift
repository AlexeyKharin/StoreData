

import Foundation
import UIKit

extension UIColor {
    
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        
        guard #available(iOS 13.0, *) else { return lightMode }
    
        return UIColor { (traitCollection: UITraitCollection) -> UIColor in
            let mode = traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
           return mode
        }
    }
}

extension UIColor {
    static let customBlue: UIColor = {
        let blue = UIColor.createColor(lightMode: .blueWhite, darkMode: .blueBlack)
        return blue
    }()
    
    static let customeBlack: UIColor = {
        let customeBlack = UIColor.createColor(lightMode: .black, darkMode: .whiteSmoke)
        return customeBlack
    }()
    
    static let customWhite: UIColor = {
        let customWhite = UIColor.createColor(lightMode: .white, darkMode: .black)
        return customWhite
    }()
    
    static let customGray: UIColor = {
        let cystomGray = UIColor.createColor(lightMode: .lightGray, darkMode: .black)
        return cystomGray
    }()
}
