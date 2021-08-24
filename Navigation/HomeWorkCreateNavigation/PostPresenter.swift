import Foundation
import UIKit
protocol FeedViewOutput {
    
    var navigationController: UINavigationController? { get set }
    
    func showPost()
}

class PostPresenter: FeedViewOutput {
    
    var navigationController: UINavigationController?
    
    func showPost() {
        if let vc = PostViewController.storyboardInstance() {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
