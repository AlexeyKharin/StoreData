
import Foundation
import UIKit
import KeychainAccess

enum AccessKey: String {
    case oneKey
}

class Coordinator: NSObject {
    
    let keychain = Keychain(service: KeychainConfiguration.serviceName)
    
    @IBOutlet weak var tabBarController: UITabBarController!
    
    private  let postPresenter = PostPresenter()
    
    private let realmDataProvider = RealmDataProvider()
    
    var key = Data(count: 64)
        
    override func awakeFromNib() {
        super.awakeFromNib()

        if keychain.allKeys().isEmpty {
            
            key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) }
            keychain[AccessKey.oneKey.rawValue] = String(data: key, encoding: .utf8)
        }
        
        if let feedNavigationfirst = tabBarController.viewControllers?.first as? UINavigationController, let feedViewController = feedNavigationfirst.viewControllers.first as? FeedViewController {
            feedViewController.output = postPresenter
            postPresenter.navigationController = feedNavigationfirst
        }
        
        if let loginNavigation = tabBarController.viewControllers?[1] as? UINavigationController, let loginController = loginNavigation.viewControllers.last as? LogInViewController {
            let viewPresenter = ViewPresenter(navigationController: loginNavigation)

            viewPresenter.realmDataProvider = realmDataProvider
            loginController.outPut = viewPresenter
            loginController.realmDataProvider = realmDataProvider

        }
    }
}

