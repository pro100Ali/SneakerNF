//
//  SecondViewController.swift
//  SneakerNF
//
//  Created by Али  on 07.06.2023.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    lazy private var firstSneaker: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onBoarding5")
        return image
    }()
    
    lazy private var secondSneaker: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onBoarding6")
        return image
    }()
    
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onBoardingVector3")?.imageRotated(byDegrees: 355)
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(firstSneaker)
        view.addSubview(secondSneaker)
        view.addSubview(image)
        setupConstraints()

    }
    func setupConstraints() {
        firstSneaker.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(47)
            make.top.equalToSuperview().inset(37)

        }
//
        secondSneaker.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(247)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(87)
        }
        image.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
//            make.leading.equalToSuperview().inset(118)
//            make.width.equalTo(200)
//            make.height.equalTo(150)
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
