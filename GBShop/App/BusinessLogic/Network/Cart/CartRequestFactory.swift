//
//  CartRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 29.08.2021.
//

import Foundation

protocol CartRequestFactory {
    func addToCartProduct(id: Int, quantity: Int, completionHandler: @escaping (Result<StandardResult, Error>) -> Void)
    func removeFromCartProduct(id: Int, completionHandler: @escaping (Result<StandardResult, Error>) -> Void)
    func payCart(completionHandler: @escaping (Result<StandardResult, Error>) -> Void)
}
