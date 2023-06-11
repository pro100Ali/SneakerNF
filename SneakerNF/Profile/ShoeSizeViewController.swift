//
//  ShoeSizeViewController.swift
//  SneakerNF
//
//  Created by Али  on 08.06.2023.
//

import UIKit
import SnapKit

class ShoeSizeViewController: UIViewController {
    
    lazy private var shoeSizeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "41.5"
        textField.backgroundColor = Constants.textFieldColor
        textField.textColor = .black
        return textField
    }()
    
    lazy private var buttonCreate: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        button.setTitle("Save changes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26

        return button
    }()
    
    @objc func saveChanges() {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(shoeSizeTextField)
        view.addSubview(buttonCreate)
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        shoeSizeTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(358)
            make.height.equalTo(48)
        }
        
        buttonCreate.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(58)
            make.height.equalTo(54)
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
