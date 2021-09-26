//
//  Purchase.swift
//  GBShop
//
//  Created by Alexander Fomin on 22.09.2021.
//

import Foundation

final class Purchase {
    static var cart = Purchase()
    static var total: Int { cart.items.reduce(0) { (total, cartItem) -> Int in
        total + cartItem.quantity * cartItem.product.price
    } }
    
    var items = [CartItem]()
    
    private init() {}
}
