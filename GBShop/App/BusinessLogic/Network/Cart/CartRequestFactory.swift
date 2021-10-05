//
//  CartRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 29.08.2021.
//

import Foundation

protocol CartRequestFactory {
    func addToCartProduct(id: Int, quantity: Int, completionHandler: @escaping (RequestResult<StandardResult>) -> Void)
    func removeFromCartProduct(id: Int, completionHandler: @escaping (RequestResult<StandardResult>) -> Void)
    func payCart(completionHandler: @escaping (RequestResult<StandardResult>) -> Void)
    func getCart(completionHandler: @escaping (RequestResult<GetCartResult>) -> Void)
}
