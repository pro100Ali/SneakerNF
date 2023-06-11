//
//  MainTabViewController.swift
//  SneakerNF
//
//  Created by Али  on 28.05.2023.
//

import UIKit
import FirebaseAuth

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let vc1 = ViewController()
        let vc2 = BasketViewController()
        let vc3 = ProfileViewController()
        self.title = Auth.auth().currentUser?.email
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "arrow.up.bin")
        vc3.tabBarItem.image = UIImage(systemName: "person.crop.circle")
//        self.delegate = self

        vc1.title = "Home"
        vc2.title = "Basket"
        vc3.title = "Profile"
        
        tabBar.tintColor = .white
        
        setViewControllers([vc1,vc2,vc3], animated: true)

    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let selectedViewController = viewController as? ViewController {
                    // Use the selected view controller
                    // Set the title to the user's name or any other desired value
                    self.title =  Auth.auth().currentUser?.email
                    
                } else {
                    // Fallback to "Cart" if a different view controller is selected
                    self.title = "Cart"
                }
        
    }



}
