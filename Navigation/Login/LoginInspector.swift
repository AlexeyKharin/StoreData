import UIKit

protocol Output {
    
    func checkLogin(login: String) -> Bool
    
    func checkPswd(pswd: String) -> Bool
    
}

class LoginInspector: Output {
    
    var login: String
    
    var pswd: String
    
    public static let shared: LoginInspector = .init()
    
    private init() {
        self.login = "Z"
        self.pswd = "Z"
        
    }
    
    func checkLogin(login: String) -> Bool {
        if login == self.login {
            return true
        } else {
            return false
        }
    }
    
    func checkPswd(pswd: String) -> Bool {
        if pswd == self.pswd {
            return true
        } else {
            return false
        }
    }
}
