//
//  CartItem.swift
//  GBShop
//
//  Created by Alexander Fomin on 25.09.2021.
//

import Foundation

struct CartItem: Equatable, Codable {
    var quantity: Int
    var product: Product
    
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        (lhs.product.id == rhs.product.id)
    }
}
