import Foundation
import CoreData
import UIKit

extension LikedContent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedContent> {
        return NSFetchRequest<LikedContent>(entityName: "LikedContent")
    }

    @NSManaged public var image: UIImage?
    @NSManaged public var likes: String?
    @NSManaged public var views: String?
    @NSManaged public var discreption: String?
    @NSManaged public var title: String?

}

extension LikedContent : Identifiable {

}
