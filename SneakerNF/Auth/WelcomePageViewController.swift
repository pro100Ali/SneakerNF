//
//  WelcomePageViewController.swift
//  SneakerNF
//
//  Created by Али  on 06.06.2023.
//

import UIKit
import SnapKit

class WelcomePageViewController: UIViewController {
    
    lazy private var backImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Vector1")
        return image
    }()
    
    lazy private var firstSneaker: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ellipse7")
        return image
    }()
    
    lazy private var secondSneaker: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ellipse62")
        return image
    }()
    
    lazy private var labelWelcome: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the biggest sneakers store app"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    lazy private var buttonSignUp: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    lazy private var buttonAlready: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.setTitle("I already have an account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .white
        view.addSubview(buttonSignUp)
        view.addSubview(buttonAlready)
        view.addSubview(labelWelcome)
        view.addSubview(backImage)
        view.addSubview(firstSneaker)
        view.addSubview(secondSneaker)
        
        setupConstraints()

    }
    @objc func signUp() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func login() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setupConstraints() {
        backImage.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalTo(339)
        }
        firstSneaker.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(312)
            make.width.equalTo(228)
        }
        
        secondSneaker.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(247)
            make.leading.equalToSuperview().inset(195)
        }
        labelWelcome.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(578)
            make.centerX.equalToSuperview()
            make.width.equalTo(358)
        }
        buttonSignUp.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(120)
            make.height.equalTo(54)
        }
        buttonAlready.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(buttonSignUp.snp.bottom).offset(24)
//            make.height.equalTo(54)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
