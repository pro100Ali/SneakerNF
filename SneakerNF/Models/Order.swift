//
//  Order.swift
//  SneakerNF
//
//  Created by Али  on 09.06.2023.
//

import Foundation

class Order {
    var arrayOfOrders: [Sneaker] = []
    let totalCost: Int
    let totalItems: Int
    
    init(totalCost: Int, totalItems: Int) {
        self.totalCost = totalCost
        self.totalItems = totalItems
    }
    
}
