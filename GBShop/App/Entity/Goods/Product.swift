//
//  Product.swift
//  GBShop
//
//  Created by Alexander Fomin on 07.08.2021.
//

import Foundation

struct Product: Hashable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price
    }
    
    let id: Int
    let name: String
    let price: Int
}
