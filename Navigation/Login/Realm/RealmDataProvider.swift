import Foundation
import RealmSwift

protocol DataProvider {
    
    func save(login: String, password: String)
    
    func obtains() -> [UserData]
    
    func delete(object: UserData)
    
}


class RealmDataProvider: DataProvider {
    
    func save(login: String, password: String) {
        let usersData = UserData()
        usersData.login = login
        usersData.password = password
        
        do {
            let realm = try! Realm(configuration: .defaultConfiguration)
            try realm.write {
                realm.add(usersData)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func obtains() -> [UserData] {
        var  modelsObject = [UserData]()
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            let models = realm.objects(UserData.self)
            modelsObject = Array(models)
        } catch {
            fatalError("ОШИБКА")
        }
        return modelsObject
    }
    
    func delete(object: UserData) {
        let realm = try! Realm(configuration: .defaultConfiguration)
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            fatalError("ОШИБКА")
        }
        
    }
}
