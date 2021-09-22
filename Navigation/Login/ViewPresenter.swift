
import Foundation
import UIKit

enum Keys: String {
    case bool
}

protocol LoginViewControllerDelegate {
    
    var realmDataProvider: DataProvider? { get set }
    
    func show()
    
    func typeEmailAndPswd()
    
    func signOut()
    
    var logIn: (() -> Void)? {get set}
    
    var pswd: String? { get set }
    
    var email: String? { get set }
}

class ViewPresenter: LoginViewControllerDelegate {
    
    var realmDataProvider: DataProvider?
    
    var logIn: (() -> Void)?
    
    var pswd: String?
    
    var email: String?
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func typeEmailAndPswd() {
        
        guard let pswd = pswd else { return }
        guard let email = email else { return }
        
        let models = self.realmDataProvider?.obtains()
        
        if models?.count != 0 {
            if let model = models?.first(where: { $0.login == email }) {
                self.realmDataProvider?.delete(object: model)
                self.realmDataProvider?.save(login: email, password: pswd)
                self.show()
                self.logIn?()
            } else {
                createAccount(email: email, pswd: pswd)
            }
        } else {
            createAccount(email: email, pswd: pswd)
        }
    }
    
    
    private func createAccount(email: String, pswd: String) {
        let alert = UIAlertController(title: "По логину аккаунт не создан", message: "Для создания аккаунта повторите пароль", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { (_) in
        }
        let actionContinue = UIAlertAction(title: "Создать", style: .default) { (_) in
            
            let textField = alert.textFields![0] as UITextField
            guard let text = textField.text else { return }
            
            if text == pswd  {
                    self.realmDataProvider?.save(login: email, password: pswd)
                    self.show()
                    self.logIn?()
            } else {
                let alertError = UIAlertController(title: "Ошибка", message: "Пароли не соотвествуют", preferredStyle: .alert)
                let actionOk = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
                    self?.signOut()
                }
                alertError.addAction(actionOk)
                self.navigationController?.present(alertError, animated: true, completion: nil)
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Не менее 4 символов"
            textField.isSecureTextEntry = true
        }
        alert.addAction(actionContinue)
        alert.addAction(actionCancel)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func signOut() {
        UserDefaults.standard.setValue(false, forKey: Keys.bool.rawValue)
    }
    
    func show() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}




