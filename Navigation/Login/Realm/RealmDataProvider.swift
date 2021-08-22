
import Foundation
import RealmSwift

protocol DataProvider {
    
    func save(login: String, password: String)
    
    func obtains() -> [UserData]
    
    func delete(object: UserData)
    
}


class RealmDataProvider: DataProvider {
    
    var key: Data
    
    init(key: Data) {
        self.key = key
    }
    
    func save(login: String, password: String) {
        var config = Realm.Configuration(encryptionKey: key)
        
        let usersData = UserData()
        usersData.login = login
        usersData.password = password
        
        do {
            let realm = try Realm(configuration: config)
            
            try! realm.write {
                realm.add(usersData)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func obtains() -> [UserData] {
        
        var config = Realm.Configuration(encryptionKey: key)
        
        var  modelsObject = [UserData]()
        
        do {
            let realm = try Realm(configuration: config)
            
            let models = realm.objects(UserData.self)
            
            modelsObject = Array(models)
            
        } catch let error {
            print(error.localizedDescription)
        }
        return modelsObject
    }
    
    func delete(object: UserData) {
        // Создаем конфигурацию для зашифрованной базы данных
        var config = Realm.Configuration(encryptionKey: key)
        
        do {
            let realm = try Realm(configuration: config)
            
            try! realm.write {
                realm.delete(object)
            }
        } catch {
            fatalError("ОШИБКА")
        }
        
    }
}
