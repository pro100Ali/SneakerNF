//
//  Sneaker.swift
//  SneakerNF
//
//  Created by Али  on 30.05.2023.
//

import Foundation

class Sneaker: Codable {
    let id: Int?
    let name: String
    let description: String
    let imageUrl: String
    var price: Int
    var count: Int?
    
    init(id: Int, name: String, description: String, imageUrl: String, price: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.price = price
        self.count = 0
    }
}


