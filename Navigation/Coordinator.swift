
import Foundation
import UIKit

class Coordinator: NSObject {
    
    @IBOutlet weak var tabBarController: UITabBarController!
    
    private  let postPresenter = PostPresenter()
    private let realmDataProvider = RealmDataProvider()
        
    override func awakeFromNib() {
        super.awakeFromNib()

        if let feedNavigationfirst = tabBarController.viewControllers?.first as? UINavigationController, let feedViewController = feedNavigationfirst.viewControllers.first as? FeedViewController {
            feedViewController.output = postPresenter
            postPresenter.navigationController = feedNavigationfirst
        }
        
        if let loginNavigation = tabBarController.viewControllers?[1] as? UINavigationController, let loginController = loginNavigation.viewControllers.last as? LogInViewController {
            let viewPresenter = ViewPresenter(navigationController: loginNavigation)

            viewPresenter.realmDataProvider = realmDataProvider
            loginController.outPut = viewPresenter
    
        }
        
    }
}

