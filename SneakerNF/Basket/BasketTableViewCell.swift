//
//  TableViewCell.swift
//  SneakerNF
//
//  Created by Али  on 03.06.2023.
//

import UIKit
import SnapKit

protocol IncreaseTheCount: AnyObject {
    func increaseTheCount(for sneaker: Sneaker)
    func decreaseTheCount(for sneaker: Sneaker)
}

class BasketTableViewCell: UITableViewCell {
    
    static var identifier = "BasketTableViewCell"
    var delegate: AddingToTheBasketDelegate?
    var delegateCount: IncreaseTheCount?
    var sneaker: Sneaker?
    
    var count: Int = 1 {
        didSet {
                scoreLabel.text = "\(count)"
        }
    }
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dolche")
        return image
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dolce&Gabbana"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 13)
        return label
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "really sofry sneakers"
        label.font = UIFont(name: "Helvetica", size: 12)

        label.textColor = .gray
        return label
    }()
    
    lazy private var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100$"
        label.font = UIFont(name: "Helvetica", size: 12)

        label.textColor = .black
        return label
    }()
    
    lazy private var buttonLabel: UIView = {
        let label = UIView()
        
//        label.setTitle("Add to cart", for: .normal)
//        label.setTitleColor(.white, for: .normal)
        label.backgroundColor = .black
        label.layer.cornerRadius = 16
        return label
    }()
    
    lazy private var buttonPlus: UIButton = {
        let label = UIButton()
        label.setImage(UIImage(systemName: "plus"), for: .normal)
        label.tintColor = .white
        label.backgroundColor = .black
        label.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        return label
    }()
    
    lazy private var buttonMinus: UIButton = {
        let label = UIButton()
        label.setImage(UIImage(systemName: "minus"), for: .normal)
        label.tintColor = .white
//        label.setTitleColor(.white, for: .normal)
        label.backgroundColor = .black
//        label.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
        return label
    }()
    
    lazy private var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(count)"
        label.textColor = .white
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [image, nameLabel, descriptionLabel, priceLabel, buttonLabel].forEach {
            contentView.addSubview($0)
        }
        buttonLabel.addSubview(buttonPlus)
        buttonLabel.addSubview(buttonMinus)
        buttonLabel.addSubview(scoreLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Sneaker) {
        let queue = DispatchQueue.global(qos: .userInteractive)
        queue.async {
            let data = try? Data(contentsOf: URL(string: model.imageUrl)!)
            DispatchQueue.main.async {
                self.image.image = UIImage(data: data!)
                self.image.contentMode = .scaleAspectFit
                self.nameLabel.text = model.name
                self.descriptionLabel.text = model.description
                self.priceLabel.text = "$\(model.price)"
                if let count = model.count {
                    self.scoreLabel.text = "\(count)"
                }
            }
        }
    }
    
    @objc func plusButtonAction() {
        count += 1
        delegateCount?.increaseTheCount(for: sneaker!)
    }

    
    @objc func minusButtonAction() {
        if count > 1 {
            count -= 1
            delegateCount?.decreaseTheCount(for: sneaker!)
        }
    }
    
    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(140)
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(16)
            
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(30)
            make.top.equalToSuperview().inset(21)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.width.equalTo(166)
            make.height.equalTo(36)
            make.leading.equalTo(nameLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
        }
        
        buttonMinus.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(48)
            make.centerY.equalToSuperview()
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.leading.equalTo(buttonMinus.snp.trailing).offset(17)
            make.centerY.equalToSuperview()
        }

        buttonPlus.snp.makeConstraints { make in
            make.leading.equalTo(scoreLabel.snp.trailing).offset(17)
            make.centerY.equalToSuperview()
        }
        
        
       
        
    }
    
}
