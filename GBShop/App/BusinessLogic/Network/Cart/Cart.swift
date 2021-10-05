//
//  Cart.swift
//  GBShop
//
//  Created by Alexander Fomin on 29.08.2021.
//

import Foundation

final class Cart: AbstractRequestFactory {
    var baseURL: String
    var networkService: NetworkServiceProtocol
    
    init(baseURL: String, networkService: NetworkServiceProtocol) {
        self.baseURL = baseURL
        self.networkService = networkService
    }

    convenience init(networkService: NetworkServiceProtocol) {
        self.init(baseURL: Constants.baseURL, networkService: networkService)
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
    
    struct GetCart: RequestRouter {
        let baseURL: String
        let path: String = "/get_cart"
        var queryItems: [URLQueryItem]?
        let data: Data? = nil
        var method: RequestRouterMethod
    }
}

extension Cart: CartRequestFactory {
    func getCart(completionHandler: @escaping (RequestResult<GetCartResult>) -> Void) {
        let requestModel = GetCart(baseURL: self.baseURL, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func addToCartProduct(id: Int, quantity: Int, completionHandler: @escaping (RequestResult<StandardResult>) -> Void) {
        let requestModel = AddProduct(baseURL: self.baseURL, productId: id, quantity: quantity, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func removeFromCartProduct(id: Int, completionHandler: @escaping (RequestResult<StandardResult>) -> Void) {
        let requestModel = RemoveProduct(baseURL: self.baseURL, productId: id, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func payCart(completionHandler: @escaping (RequestResult<StandardResult>) -> Void) {
        let requestModel = PayCart(baseURL: self.baseURL, method: .post)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
}
