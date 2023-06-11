//
//  CompletedViewController.swift
//  SneakerNF
//
//  Created by Али  on 05.06.2023.
//

import UIKit
import SnapKit

class CompletedViewController: UIViewController {
    lazy private var text: UILabel = {
        let text = UILabel()
        text.text = "Your order is succesfully placed. Thanks!"
        text.font = UIFont.systemFont(ofSize: 28, weight: .semibold)

//        text.font = UIFont(name: "Helvetica", size: 28)
        text.numberOfLines = 2
        text.textAlignment = .center
        
        return text
    }()
    lazy private var image1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ellipse5")
        image.layer.borderWidth = 8
        image.layer.borderColor = Constants.textFieldColor.cgColor
        image.layer.cornerRadius = 70
        return image
    }()
    lazy private var image2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Ellipse6")
        image.layer.borderWidth = 8
        image.layer.borderColor = Constants.textFieldColor.cgColor
        image.layer.cornerRadius = 70
        return image
    }()
    
    lazy private var buttonGetBack: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(getBack), for: .touchUpInside)
        button.setTitle("Get back to shopping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        return button
    }()
    
    lazy private var backImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Vector21")
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(text)
        view.addSubview(image1)
        view.addSubview(image2)
        view.addSubview(buttonGetBack)
        view.addSubview(backImage)
        setupConstraints()
    }
    
    @objc func getBack() {
        let vc = BasketViewController()
        print("asdda")
        self.dismiss(animated: true)
        vc.navigationController?.pushViewController(vc, animated: true)
    }
    func setupConstraints() {
        image1.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(140)
            make.top.equalToSuperview().inset(60)
            make.leading.equalToSuperview().inset(86)
        }
        
        image2.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(140)
            make.top.equalToSuperview().inset(104)
            make.trailing.equalToSuperview().inset(84)
        }
        
        text.snp.makeConstraints { make in
            make.top.equalTo(image2.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(358)
        }
        
        buttonGetBack.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(54)
            make.centerX.equalToSuperview()
            make.top.equalTo(text.snp.bottom).offset(20)
        }
        backImage.snp.makeConstraints { make in
            make.height.equalTo(145)
            make.width.equalTo(340)
        }
    }
}
