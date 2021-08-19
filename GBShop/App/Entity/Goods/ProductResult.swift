//
//  ProductResult.swift
//  GBShop
//
//  Created by Alexander Fomin on 07.08.2021.
//

import Foundation

struct ProductResult: Codable {
    enum CodingKeys: String, CodingKey {
        case result
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
    
    let result: Int
    let name: String
    let price: Int
    let description: String
}
