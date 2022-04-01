//
//  CartRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 29.08.2021.
//

import Foundation

protocol CartRequestFactory {
    func addToCartProduct(id: Int, quantity: Int, completionHandler: @escaping (AbstractResult<StandardResult>) -> Void)
    func removeFromCartProduct(id: Int, completionHandler: @escaping (AbstractResult<StandardResult>) -> Void)
    func payCart(completionHandler: @escaping (AbstractResult<StandardResult>) -> Void)
    func getCart(completionHandler: @escaping (AbstractResult<GetCartResult>) -> Void)
}
