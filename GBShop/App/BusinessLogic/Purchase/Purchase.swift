//
//  Purchase.swift
//  GBShop
//
//  Created by Alexander Fomin on 22.09.2021.
//

import Foundation

final class Purchase: Hashable {
    static var cart = Purchase()
   
    var items = [CartItem]()
    var total: Int { self.items.reduce(0) { (total, cartItem) -> Int in
        total + cartItem.quantity * cartItem.product.price
    } }
    
    private init() {}
    
    static func == (lhs: Purchase, rhs: Purchase) -> Bool {
        lhs.items == rhs.items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(items.hashValue)
    }
}
