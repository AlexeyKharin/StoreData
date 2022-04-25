import UIKit

class LogInViewController: UIViewController {
        
    var outPut: LoginMock?
    
    var realmDataProvider: RealmDataProvider?
    
    var currentUser: Bool = false
    
    private var email: String?
    
    private var pswd: String?
    
    var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.toAutoLayout()
        return image
    }()
    
    lazy var buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Log in", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.toAutoLayout()
        button.backgroundColor = .customBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(press), for: .touchUpInside)
        return button
    }()
    
    @objc func press () {
        guard let email = email else { return }
        guard let pswd = pswd else { return }
        outPut?.typeEmailAndPswd(email: email, pswd: pswd)
    }
    
    func showButtonOut() {
        containerView.addSubview(buttonOut)
        let constraints = [
            buttonOut.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            buttonOut.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            buttonOut.widthAnchor.constraint(equalToConstant: 70),
            buttonOut.heightAnchor.constraint(equalToConstant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
//    MARK:- Out from account
    lazy var buttonOut: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Sign Out", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.toAutoLayout()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1), for: .normal)
        
        button.layer.cornerRadius = 3
        button.contentHorizontalAlignment = .center
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()
    
    @objc func signOut () {
        outPut?.userLogIn?(false)
        buttonOut.removeFromSuperview()
        textfieldOne.text = ""
        textfieldTwo.text = ""
    }
    
    var stack: UIStackView = {
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.spacing = 0
        stack.layer.borderWidth = 0.5
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.axis = .vertical
        stack.layer.cornerRadius = 10
        stack.clipsToBounds = true
        return stack
    }()
    
    lazy var textfieldOne: MyTextField = {
        let textField = MyTextField()
        textField.toAutoLayout()
        print("textField \(type(of: self))")
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.delegate = self
        textField.placeholder = "Password"
        textField.accessibilityIdentifier = "Password"
        textField.addTarget(self, action: #selector(disAbleButton), for: .editingChanged)
        return textField
    }()
    
    lazy var textfieldTwo: MyTextField = {
        let textField = MyTextField()
        textField.toAutoLayout()
        print("textField \(type(of: self))")
        textField.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textField.backgroundColor = .systemGray6
        textField.returnKeyType = .continue
        textField.delegate = self
        textField.placeholder = "Email of phone"
        textField.accessibilityIdentifier = "Email"
        textField.returnKeyType = .continue
        textField.addTarget(self, action: #selector(disAbleButton), for: .editingChanged)
        return textField
    }()
    
    
    @objc func disAbleButton() {

        if let password = textfieldOne.text, let email = textfieldTwo.text, password.count > 3, email.count > 3 {
            buyButton.isEnabled = true
           
            self.pswd = textfieldOne.text
            self.email = textfieldTwo.text
            
        } else {
            buyButton.isEnabled = false
        }
    }

    private let containerView: UIView = {
        let containerView = UIView()
        containerView.toAutoLayout()
        return containerView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.toAutoLayout()
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disAbleButton()
        print(CurrentUser.value)
        outPut?.userLogIn = { currentUser in
            self.showButtonOut()
            CurrentUser.value = currentUser
            self.currentUser = CurrentUser.value
        }
        
        if currentUser == true {
            let models = realmDataProvider?.obtains()
            
            textfieldOne.text = models?.last?.password
            textfieldTwo.text = models?.last?.login
            email = textfieldTwo.text
            pswd = textfieldOne.text
            guard  let email = email else { return }
            guard let pswd = pswd else { return }
            
            outPut?.typeEmailAndPswd(email: email, pswd: pswd)
            
        } else {
            textfieldOne.text = ""
            textfieldTwo.text = ""
        }
        
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [stack, buyButton, image].forEach { containerView.addSubview($0) }
        stack.addArrangedSubview(textfieldTwo)
        stack.addArrangedSubview(textfieldOne)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
            image.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100),
            
            stack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 120),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            
            buyButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16),
            buyButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            buyButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
            buyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    /// Keyboard observers
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case textfieldTwo:
            textfieldOne.becomeFirstResponder()
        case textfieldOne:
            textfieldOne.resignFirstResponder()
        default: break
            
        }
        return true
    }
}

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

class MyTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10 , dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
}


