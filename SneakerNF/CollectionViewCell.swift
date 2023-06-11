//
//  CollectionViewCell.swift
//  SneakerNF
//
//  Created by Али  on 28.05.2023.
//

import UIKit
import SnapKit

protocol AddingToTheBasketDelegate: AnyObject {
    func addToBasket(for sneaker: Sneaker)
    func removeFromBasket(for sneaker: Sneaker)
}




class CollectionViewCell: UICollectionViewCell, ChangeTheTitle {
    func changeTitle(for sneaker: Int) {
        if let item = getArrayOfSneakers!().first(where: { $0.id == sneaker }) {
//            print("Found item with ID \(itemId): \(item.name)")
            print("hello leme talk \(item)")
        }
    }
    
    
    private var isAddedToCart = false

//    weak var dataSource: SneakerDataSource?
    var indexPath: IndexPath?
    var getArrayOfSneakers: (() -> [Sneaker])?
    
    static var identifier = "CollectionViewCell"
    
    var delegate: AddingToTheBasketDelegate?
    
 
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dolche")
        return image
    }()
    
    lazy private var nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Dolce&Gabbana"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy private var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "really sofry sneakers"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    lazy private var priceLabel: UILabel = {
       let label = UILabel()
        label.text = "100$"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy private var buttonLabel: UIButton = {
       let label = UIButton()
        label.setTitle("Add to cart", for: .normal)
        label.setTitleColor(.white, for: .normal)
        label.backgroundColor = .black
        label.layer.cornerRadius = 16
        label.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [image, nameLabel, descriptionLabel, priceLabel, buttonLabel].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .white
        setupConstraints()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func addToBasket() {
        
        if !isAddedToCart  {
            delegate?.addToBasket(for: getArrayOfSneakers!()[indexPath!.row])
            print(getArrayOfSneakers!()[indexPath!.row])
            
            buttonLabel.setTitle("Remove", for: .normal)
            
            isAddedToCart.toggle()
        }
        else {
            delegate?.removeFromBasket(for: getArrayOfSneakers!()[indexPath!.row])
            buttonLabel.setTitle("Add to Cart", for: .normal)
            isAddedToCart.toggle()
        }
    }
    
    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(4)
            make.width.equalTo(166)
            make.height.equalTo(166)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(4)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(4)
        }
        
        buttonLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(4)
        }
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
                }
            }
        }
    
    func configureTitle() {
//        if let item = getArrayOfSneakers!().first(where: { $0.id == id }) {
//            buttonLabel.setTitle("Add to basket - \(item.name)", for: .normal)
//        } else {
//            buttonLabel.setTitle("Add to basket", for: .normal)
//        }
//        print("im hcanging the \(id)")
           isAddedToCart = false
           buttonLabel.setTitle("Add to basket", for: .normal)

    }
}
