//
//  SignOutViewController.swift
//  SneakerNF
//
//  Created by Али  on 05.06.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    lazy private var backViewInfo: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12

        return view
    }()
    
    lazy private var backViewHistory: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12

        return view
    }()
    
    lazy private var backViewShoe: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy private var textInfo: UILabel = {
       let text = UILabel()
        text.text = "Account Information"
        view.layer.cornerRadius = 12

        return text
    }()
    
    lazy private var textHistory: UILabel = {
       let text = UILabel()
        text.text = "Order History"
        return text
    }()
    
    lazy private var textShoe: UILabel = {
       let text = UILabel()
        text.text = "Shoe size"
        return text
    }()
    
    lazy private var buttonSignOut: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        return button
    }()
    lazy private var buttonInfo: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = UIColor(red: 0.77, green: 0.77, blue: 0.78, alpha: 1.00)
        return button
    }()
    
    lazy private var buttonHistory: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = UIColor(red: 0.77, green: 0.77, blue: 0.78, alpha: 1.00)

        return button
    }()
    
    lazy private var buttonShoe: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = UIColor(red: 0.77, green: 0.77, blue: 0.78, alpha: 1.00)

        return button
    }()

    lazy private var backViewCheckSize: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12

        return view
    }()
    
    lazy private var backViewAuth: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12

        return view
    }()
    
    lazy private var textCheckSize: UILabel = {
       let text = UILabel()
        text.text = "How to know your shoe size?"
        return text
    }()
    
    lazy private var textAuth: UILabel = {
       let text = UILabel()
        text.text = "How to check the authenticity of the shoe?"
        text.numberOfLines = 2
        return text
    }()
    
    
    lazy private var buttonCheckSize: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = UIColor(red: 0.77, green: 0.77, blue: 0.78, alpha: 1.00)
        button.addTarget(self, action: #selector(openWebsiteCheckSize), for: .touchUpInside)

        return button
    }()
    
    lazy private var buttonAuth: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = UIColor(red: 0.77, green: 0.77, blue: 0.78, alpha: 1.00)
        button.addTarget(self, action: #selector(openWebsiteAuth), for: .touchUpInside)
        return button
    }()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        
        view.backgroundColor = Constants.textFieldColor
        view.addSubview(buttonSignOut)
        
        view.addSubview(backViewInfo)
        backViewInfo.addSubview(textInfo)
        backViewInfo.addSubview(buttonInfo)
        
        view.addSubview(backViewShoe)
        backViewHistory.addSubview(textHistory)
        backViewHistory.addSubview(buttonHistory)
        
        view.addSubview(backViewHistory)
        backViewShoe.addSubview(textShoe)
        backViewShoe.addSubview(buttonShoe)
       
        view.addSubview(backViewCheckSize)
        backViewCheckSize.addSubview(textCheckSize)
        backViewCheckSize.addSubview(buttonCheckSize)
        
        
        view.addSubview(backViewAuth)
        backViewAuth.addSubview(textAuth)
        backViewAuth.addSubview(buttonAuth)
        
        setupConstraints()
        
        
        let tapShoeSizw = UITapGestureRecognizer(target: self, action: #selector(openShoeSize))
        
        let tapAccInfo = UITapGestureRecognizer(target: self, action: #selector(openAccountInfo))
        
        let tapCheckSize = UITapGestureRecognizer(target: self, action: #selector(openWebsiteCheckSize))
        let tapAuth = UITapGestureRecognizer(target: self, action: #selector(openWebsiteCheckSize))
        backViewCheckSize.addGestureRecognizer(tapCheckSize)
        backViewAuth.addGestureRecognizer(tapAuth)
        backViewInfo.addGestureRecognizer(tapAccInfo)
        backViewShoe.addGestureRecognizer(tapShoeSizw)
        
        
    }
    
    @objc func openShoeSize() {
        let vc = ShoeSizeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func openAccountInfo() {
        let vc = AccountInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func openWebsiteCheckSize() {
        if let url = URL(string: "https://www.nike.com/a/how-to-measure-foot-size") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func openWebsiteAuth() {
        if let url = URL(string: "https://hypestew.com/blogs/news/legit-check") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func signOut() {
        let alert = UIAlertController(title: "Confirmation", message: "Are you sure you want to sign out?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                print("Successfully signed out")
                
                let vc = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                vc.navigationItem.hidesBackButton = true
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    
    func setupConstraints() {
        backViewInfo.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(52)
            make.top.equalToSuperview().inset(134)
        }
        
        textInfo.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        buttonInfo.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(19)
            make.centerY.equalToSuperview()
            
        }
        
        backViewHistory.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(52)
            make.top.equalTo(backViewInfo.snp.bottom).offset(16)
        }
        
        textHistory.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        buttonHistory.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(19)
            make.centerY.equalToSuperview()
        }
        
        backViewShoe.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(52)
            make.top.equalTo(backViewHistory.snp.bottom).offset(16)
        }
        
        textShoe.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        buttonShoe.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(19)
            make.centerY.equalToSuperview()
        }
        
        
        backViewCheckSize.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(52)
            make.top.equalTo(backViewShoe.snp.bottom).offset(16)
        }
        
        backViewAuth.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(74)
            make.top.equalTo(backViewCheckSize.snp.bottom).offset(16)
        }
        
        textCheckSize.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.trailing.equalToSuperview()
        }
        
        textAuth.snp.makeConstraints { make in
            make.width.equalTo(260)
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
        
        buttonCheckSize.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(19)
            make.centerY.equalToSuperview()
        }
        
        buttonAuth.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(19)
            make.centerY.equalToSuperview()
        }
        
        
        buttonSignOut.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(103)
            make.height.equalTo(54)
        }
    }
}
