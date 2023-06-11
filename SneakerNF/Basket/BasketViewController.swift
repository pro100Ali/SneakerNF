//
//  BasketViewController.swift
//  SneakerNF
//
//  Created by Али  on 29.05.2023.
//

import UIKit
import SnapKit

protocol ChangeTheTitle: AnyObject {
    func changeTitle(for sneaker: Int)
}

class BasketViewController: UIViewController {
    
    var basket: [Sneaker] = []
    var orders: Order?
    var totalCost: Int = 0
    var totalItems: Int = 0
    
    var delegate: ChangeTheTitle?
    
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Vector1")?.imageRotated(byDegrees: 10)
        return image
    }()
    
    lazy private var cardIsEmpty: UILabel = {
        let label = UILabel()
        label.text = "Cart is empty"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Find interesting models in the Catalog."
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = .black
        return label
    }()
    
    lazy private var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Constants.textFieldColor
        table.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.identifier)
        return table
    }()
    
    lazy private var buttonConfirm: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        button.setTitle("Confirm Order", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        return button
    }()
    lazy private var totalCostView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy private var countLabel: UILabel = {
       let label = UILabel()
        label.text = "\(totalItems) items: Total (Including Delivery)"
        label.font = UIFont(name: "Helvetica", size: 13)
        return label
    }()
    
    lazy private var priceLabel: UILabel = {
       let label = UILabel()
        label.text = "$\(totalCost)"
        label.font = UIFont(name: "Helvetica", size: 13)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.textFieldColor
        view.addSubview(image)
        view.addSubview(cardIsEmpty)
        view.addSubview(descriptionLabel)
        view.addSubview(tableView)
        view.addSubview(buttonConfirm)
        view.addSubview(totalCostView)
        totalCostView.addSubview(priceLabel)
        totalCostView.addSubview(countLabel)
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraintsEmpty()
        setupConstraintsBasket()
        print(basket)
        view.backgroundColor = .white
        image.transform = image.transform.rotated(by: .pi / 0.1)
        updateUI()

        
        if let vc = tabBarController?.viewControllers?[0] as? ViewController {
//            vc.changeTitle(for: sneaker)
            self.delegate = vc
        }
        
    }
    
    @objc func confirm() {
        let vc = CompletedViewController()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(vc, animated: true, completion: nil)
    }
    

    
    func updateUI() {
        if basket.isEmpty {
            image.isHidden = false
            cardIsEmpty.isHidden = false
            descriptionLabel.isHidden = false
            tableView.isHidden = true
            buttonConfirm.isHidden = true
            totalCostView.isHidden = true
        } else {
            image.isHidden = true
            cardIsEmpty.isHidden = true
            descriptionLabel.isHidden = true
            tableView.isHidden = false
            buttonConfirm.isHidden = false
            totalCostView.isHidden = false
        }
    }
    func setupConstraintsBasket() {
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(625)
        }
        buttonConfirm.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(103)
            make.height.equalTo(54)
        }
        totalCostView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(tableView.snp.bottom).offset(16)
        }
        countLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(160)
        }
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func setupConstraintsEmpty() {
        image.snp.makeConstraints { make in
            make.width.equalTo(400)
            make.height.equalTo(339)
        }
        cardIsEmpty.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cardIsEmpty.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
 
    }
    func updateTotalCost(item totalItems: Int, cost totalCost: Int) {
        priceLabel.text = "$\(totalCost)"
        countLabel.text = "\(totalItems) items: Total (Including Delivery)"
    }
    
    func getSneakerFromBasket(byId id: Int) -> Sneaker? {
        for sneaker in basket {
            if let sneakerId = sneaker.id, sneakerId == id {
                return sneaker
            }
        }
        return nil // No matching sneaker found
    }
}

extension UIImage {
    func imageRotated(byDegrees degrees: CGFloat) -> UIImage? {
        let radians = degrees * CGFloat.pi / 180.0
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: size.width / 2, y: size.height / 2)
            context.rotate(by: radians)
            draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return rotatedImage
        }
        return nil
    }
}


extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        print(basket.count)
//        return basket.count
//    }
//
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basket.count
    }
    
//
//    // Set the spacing between sections
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 5
//    }
//
//    // Make the background color show through
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as! BasketTableViewCell
        cell.backgroundColor = .white
        print("in cell \(basket.count)")
        cell.configure(with: basket[indexPath.row])
//        cell.delegate = self
        cell.delegateCount = self
        cell.sneaker = basket[indexPath.row]
        cell.sneaker?.count = 1
        cell.selectionStyle = .none
        print("the basket is \(basket)")
        print("this one is \(basket[indexPath.row].name)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            removeFromBasket(for: basket[indexPath.row].id!)
            delegate?.changeTitle(for: basket[indexPath.row].id!)
            self.totalCost -= basket[indexPath.row].price
            self.totalItems -= basket[indexPath.row].count!
            updateTotalCost(item: totalItems, cost: totalCost)
            basket = basket.filter { $0.id !=  basket[indexPath.row].id  }
            print("i m deletnig the \(indexPath.row)")
            print(basket)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateUI()
        }
    }

}

extension BasketViewController: AddingToTheBasketDelegate, IncreaseTheCount {

    
    func decreaseTheCount(for sneaker: Sneaker) {
        if var count = sneaker.count {
            print("Total cost is \(totalCost)")
                count -= 1
                sneaker.count = count
            self.totalItems -= 1
            self.totalCost -= sneaker.price
            self.updateTotalCost(item: totalItems, cost: totalCost)
            print(totalCost)
            }
    }
    
    func increaseTheCount(for sneaker: Sneaker) {
        
        if var count = sneaker.count {
            print("Total cost is \(totalCost)")
                count += 1
                sneaker.count = count
            self.totalItems += 1
            self.totalCost += sneaker.price
            self.updateTotalCost(item: totalItems, cost: totalCost)
            print(totalCost)
            }
        print(sneaker.count)
    }
    
  
    
    
    func removeFromBasket(for sneaker: Sneaker) {
        print("im deleting the \(sneaker)")
        basket = basket.filter { $0.id !=  sneaker.id  }
        self.totalItems -= (sneaker.count!)
        self.totalCost -= (sneaker.price * sneaker.count!)
        self.updateTotalCost(item: totalItems, cost: totalCost)
        tableView.reloadData()
        updateUI()
        
    }
    
    func addToBasket(for sneaker: Sneaker) {
        
        self.basket.append(sneaker)
        print("Total cost is \(totalCost)")
        
        self.totalItems += 1
        print(totalItems)
        self.totalCost += sneaker.price
        
        updateTotalCost(item: totalItems, cost: totalCost)
        tableView.reloadData()
        
        updateUI()
    }
}

