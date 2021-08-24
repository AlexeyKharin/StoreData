import Foundation

class JsonSerializationToObject {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    
    init(userId: Int,  id: Int, title: String, completed: Bool) {
        self.userId = userId
        self.completed = completed
        self.title = title
        self.id = id
    }
}
