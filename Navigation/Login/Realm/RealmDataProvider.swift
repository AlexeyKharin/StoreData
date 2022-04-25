import Foundation
import RealmSwift
import KeychainAccess

protocol DataProvider {
    
    func save(login: String, password: String)
    
    func obtains() -> [UserData]
    
    func delete(object: UserData)
    
}

class RealmDataProvider: DataProvider {
    
    let keychain = Keychain(service: KeychainConfiguration.serviceName)
 
    func save(login: String, password: String) {
        
        let key = keychain[AccessKey.oneKey.rawValue]?.data(using: .utf8)
        let config = Realm.Configuration(encryptionKey: key)
        
        let usersData = UserData()
        usersData.login = login
        usersData.password = password
        
        do {
            let realm = try! Realm(configuration: config)
            try realm.write {
                realm.add(usersData)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func obtains() -> [UserData] {
        
        let key = keychain[AccessKey.oneKey.rawValue]?.data(using: .utf8)
        let config = Realm.Configuration(encryptionKey: key)
        
        var  modelsObject = [UserData]()
        do {
            let realm = try Realm(configuration: config)
            let models = realm.objects(UserData.self)
            modelsObject = Array(models)
        } catch {
            fatalError("ОШИБКА")
        }
        return modelsObject
    }
    
    func delete(object: UserData) {
        
        let key = keychain[AccessKey.oneKey.rawValue]?.data(using: .utf8)
        let config = Realm.Configuration(encryptionKey: key)
        
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.delete(object)
            }
        } catch {
            fatalError("ОШИБКА")
        }
        
    }
}
