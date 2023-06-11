//
//  ViewController.swift
//  SneakerNF
//
//  Created by Али  on 28.05.2023.
//

import UIKit
import SnapKit
import FirebaseAuth



class ViewController: UIViewController {
    
//    var basket: [Sneaker] = [Sneaker(id: 1, name: "As", desciption: "ASd", image: "As", price: 12), Sneaker(id: 2, name: "As", desciption: "ASd", image: "As", price: 12)]
    
    
    var arrayOfSneaker: [Sneaker] = []
    var selectedCell: CollectionViewCell?

  
    lazy private var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 174, height: 282)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = true

        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        view.addSubview(collection)
        collection.delegate = self
        collection.dataSource = self
        setupConstraints()
        APICaller.shared.handleRequest { res in
            switch res {
            case .success(let success):
                print("success is \(success)")
                DispatchQueue.main.async {
                    self.arrayOfSneaker = success
                    self.collection.reloadData()
                }
            case .failure(let failure):
                print("Error", failure)
            }
        }
     
        
    }
    
    
    func setupConstraints() {
        collection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
    }
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfSneaker.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .white
        cell.configure(with: arrayOfSneaker[indexPath.row])
        cell.layer.cornerRadius = 4
        cell.delegate = self
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                selectedCell = cell
            }
        
        cell.getArrayOfSneakers = {
            return self.arrayOfSneaker
        }
//        cell.dataSource = self
        cell.indexPath = indexPath
        
//        self.changeTitle(for: indexPath.row)
//        if indexPath == selectedIndexPath {
               selectedCell = cell
//           }
        return cell
    }
    
}

extension ViewController:  AddingToTheBasketDelegate, ChangeTheTitle {
    func changeTitle(for sneaker: Int) {
//        guard let cell = selectedCell else {
//               return
//           }
        
        if let item = arrayOfSneaker.first(where: { $0.id == sneaker }) {
            print("Found item with ID \(item.name)")
                guard let cell = selectedCell else {
                    return
                }
                
                if let item = arrayOfSneaker.first(where: { $0.id == sneaker }) {
//                    cell.changeTitle(for: <#T##Int#>)
                    cell.configureTitle()
                }
        }
        
//        cell.configureTitle(with: arrayOfSneaker[sneaker])
     
    }
    
    func removeFromBasket(for sneaker: Sneaker) {
        if let vc = tabBarController?.viewControllers?[1] as? BasketViewController {
            vc.removeFromBasket(for: sneaker)
            
        }
    }
    
    
    func addToBasket(for sneaker: Sneaker) {
        if let vc = tabBarController?.viewControllers?[1] as? BasketViewController {
            vc.addToBasket(for: sneaker)
        }
    }
    
//    
//    func getArrayOfSneakers() -> [Sneaker] {
//        return arrayOfSneaker
//    }
}
