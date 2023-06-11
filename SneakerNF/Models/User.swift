//
//  User.swift
//  SneakerNF
//
//  Created by Али  on 31.05.2023.
//

import Foundation

struct User: Codable {
    
    let id: UUID
    let name: String
    let otdeleeniya: Int
    let shoeSize: Int
}
