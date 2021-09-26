//
//  AddToCartRequstBody.swift
//  GBShop
//
//  Created by Alexander Fomin on 29.08.2021.
//

import Foundation

struct AddToCartRequstBody: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case quantity
    }
    
    let id: Int
    let quantity: Int
}
