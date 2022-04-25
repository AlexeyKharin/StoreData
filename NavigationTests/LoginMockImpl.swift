
import Foundation
import UIKit
@testable import Navigation

class LoginMockImpl: LoginMock {
    
    var logIn: (() -> Void)?
    
    private let email = "Egor"
    
    private let pswd = "123456"
    
    var userLogIn: ((Bool) -> Void)?
        
    var displaySuccessControllerCounter: Int = 0
    
    var successAuthorizationCounter: Int = 0
    
    var failedAuthorizationCounter: Int = 0
    
    func show() {
        displaySuccessControllerCounter += 1
    }
    
    func typeEmailAndPswd(email: String, pswd: String) {
        
        if email == self.email && pswd == self.pswd {
            successAuthorizationCounter += 1
            print(successAuthorizationCounter)
            show()
        } else {
            successAuthorizationCounter = 0
            signOut()
        }
        
        DispatchQueue.global(qos: .background).async {
            let result = email == self.email && pswd == self.pswd
            self.userLogIn?(result)
        }
       
    }
    
    func signOut() {
        failedAuthorizationCounter += 1
    }
   
}
