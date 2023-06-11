//
//  LoginViewController.swift
//  SneakerNF
//
//  Created by Али  on 01.06.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    lazy private var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.backgroundColor = Constants.textFieldColor
        textField.textColor = .black
        return textField
    }()
    
    lazy private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = Constants.textFieldColor
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.textAlignment = .left
        return textField
    }()
    
    lazy private var buttonCreate: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        
        return button
    }()
//    4kXltg9iJJcmt1RbQdWWfIn8Kc12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(buttonCreate)
        setupConstraints()
        self.navigationItem.title = "Welcome back!"
        
        if let _ = Auth.auth().currentUser {
            let vc = MainTabViewController()
            vc.navigationItem.hidesBackButton = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @objc func signIn() {
        if let userName = usernameTextField.text, let password = passwordTextField.text{
            
            Auth.auth().signIn(withEmail: userName, password: password) { authResult, error in
                
                if let error = error {
                    print(error)
                    return
                }
                if let authResult = authResult {
                    print("he is signed in \(authResult.user.uid)")

                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    
                    let vc = MainTabViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.title = Auth.auth().currentUser?.email
                    vc.navigationItem.hidesBackButton = true

                    if let navigationController = self.navigationController {
                                navigationController.navigationBar.prefersLargeTitles = false
                                navigationController.pushViewController(vc, animated: true)
                            }
                }
                
            }
            
        }
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
            
            buttonCreate.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(58)
                make.height.equalTo(54)
            }
            
            
        }
        
    }
    
    

