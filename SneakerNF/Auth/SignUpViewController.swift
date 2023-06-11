//
//  LoginViewController.swift
//  SneakerNF
//
//  Created by Али  on 31.05.2023.
//

import UIKit
import SnapKit
import FirebaseAuth


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
//    var ref: DatabaseReference!
//
//    ref = Database.database().reference()
//
    lazy private var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.backgroundColor = Constants.textFieldColor
        textField.textColor = .black
        return textField
    }()
    
    lazy private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.backgroundColor = Constants.textFieldColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.textAlignment = .left
        return textField
    }()
    
    lazy private var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "again password"
        textField.backgroundColor = Constants.textFieldColor
        textField.isSecureTextEntry = true
        textField.textColor = .black    
        return textField
    }()
    
    lazy private var buttonCreate: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(createUser), for: .touchUpInside)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = .black
        button.layer.cornerRadius = 26

        return button
    }()
    
    lazy private var userNamecheckMark: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.tintColor = .green
        image.isHidden = true

        return image
    }()
    
    lazy private var passwordCheckMark: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.tintColor = .green
        image.isHidden = true

        return image
    }()
    
    lazy private var confirmCheckMark: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "xmark")
        image.tintColor = .green
        image.isHidden = true

        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Set up the text fields
        usernameTextField.delegate = self
        usernameTextField.textColor = .black // Set font color to black
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        passwordTextField.textColor = .black // Set font color to black

        confirmPasswordTextField.delegate = self
        
        [usernameTextField, passwordTextField, confirmPasswordTextField, confirmPasswordTextField, buttonCreate, userNamecheckMark, passwordCheckMark, confirmCheckMark].forEach {
            view.addSubview($0)
        }
        
        setupConstraints()
        
    }
    
    @objc func createUser() {
        if let userName = usernameTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text {
            if userName.isValidEmail() && isValidPassword(password) && password == confirmPassword  {
                Auth.auth().createUser(withEmail: userName, password: password) { authResult, error in
                    if let authResult = authResult {
                        print(authResult.user.uid)
                    }
                    if let error = error {
                        print(error )
                    }
                }
            }
            else {
                print("You didn't make the requirmeents")
            }
    
        }
       
        

        
        
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//          // ...
//        }
    }
    
    
    private func isValidPassword(_ password: String) -> Bool {
        
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        switch textField {
            case usernameTextField:
            if usernameTextField.text?.count != 0 {
                userNamecheckMark.isHidden = false
            }
            if updatedText.isValidEmail()  {
                userNamecheckMark.image = UIImage(systemName: "checkmark")
                userNamecheckMark.tintColor = .green
            }
             else {
                 userNamecheckMark.image = UIImage(systemName: "xmark")
                 userNamecheckMark.tintColor = .red

             }
        case passwordTextField:
            if isValidPassword(updatedText) {
                passwordCheckMark.image = UIImage(systemName: "checkmark")
                passwordCheckMark.tintColor = .green
            }
             else {
                 passwordCheckMark.image = UIImage(systemName: "xmark")
                 passwordCheckMark.tintColor = .red
             }
        default:
            if passwordTextField.text == updatedText {
                confirmCheckMark.image = UIImage(systemName: "checkmark")
                confirmCheckMark.tintColor = .green
            }
             else {
                 confirmCheckMark.image = UIImage(systemName: "xmark")
                 confirmCheckMark.tintColor = .red
             }
        }
  
        return true
    }
    
    func setupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(358)
            make.height.equalTo(48)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.width.equalTo(358)
            make.height.equalTo(48)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalTo(358)
            make.height.equalTo(48)
        }
        buttonCreate.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(58)
            make.height.equalTo(54)
        }
        
        userNamecheckMark.snp.makeConstraints { make in
            make.centerY.equalTo(usernameTextField)
            make.leading.equalTo(usernameTextField.snp.trailing).inset(30)
        }
        passwordCheckMark.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.leading.equalTo(passwordTextField.snp.trailing).inset(30)
        }
        confirmCheckMark.snp.makeConstraints { make in
            make.centerY.equalTo(confirmPasswordTextField)
            make.leading.equalTo(confirmPasswordTextField.snp.trailing).inset(30)
        }
    }
}

