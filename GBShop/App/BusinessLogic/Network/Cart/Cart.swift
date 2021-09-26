//
//  Cart.swift
//  GBShop
//
//  Created by Alexander Fomin on 29.08.2021.
//

import Foundation

final class Cart: AbstractRequestFactory {
    var baseURL: String
    var errorParser: AbstractErrorParser
    var sessionManager: URLSession
    
    init(baseURL: String, errorParser: AbstractErrorParser, sessionManager: URLSession) {
        self.baseURL = baseURL
        self.errorParser = errorParser
        self.sessionManager = sessionManager
    }

    convenience init(errorParser: AbstractErrorParser, sessionManager: URLSession) {
        self.init(baseURL: Constants.baseURL, errorParser: errorParser, sessionManager: sessionManager)
    }
}

extension Cart {
    struct AddProduct: RequestRouter {
        let baseURL: String
        let path: String = "/add_to_cart"
        let productId: Int
        let quantity: Int
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "id_product", value: "\(productId)"),
                    URLQueryItem(name: "quantity", value: "\(quantity)")]
        }
        let data: Data? = nil
        var method: RequestRouterMethod
    }
    
    struct RemoveProduct: RequestRouter {
        let baseURL: String
        let path: String = "/remove_from_cart"
        let productId: Int
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "id_product", value: "\(productId)")]
        }
        let data: Data? = nil
        var method: RequestRouterMethod
    }
    
    struct PayCart: RequestRouter {
        let baseURL: String
        let path: String = "/pay_cart"
        var queryItems: [URLQueryItem]?
        let data: Data? = nil
        var method: RequestRouterMethod
    }
}

extension Cart: CartRequestFactory {
    func addToCartProduct(id: Int, quantity: Int, completionHandler: @escaping (Result<StandardResult, Error>) -> Void) {
        let requestModel = AddProduct(baseURL: self.baseURL, productId: id, quantity: quantity, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func removeFromCartProduct(id: Int, completionHandler: @escaping (Result<StandardResult, Error>) -> Void) {
        let requestModel = RemoveProduct(baseURL: self.baseURL, productId: id, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func payCart(completionHandler: @escaping (Result<StandardResult, Error>) -> Void) {
        let requestModel = PayCart(baseURL: self.baseURL, method: .post)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
}
