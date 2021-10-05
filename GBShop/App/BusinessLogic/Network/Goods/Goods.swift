//
//  Goods.swift
//  GBShop
//
//  Created by Alexander Fomin on 07.08.2021.
//

import Foundation

final class Goods: AbstractRequestFactory {
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

extension Goods: GoodsRequestFactory {
    func getProductById(id: Int, completionHandler: @escaping (RequestResult<ProductResult>) -> Void) {
        let requestModel = ProductById(baseURL: self.baseURL, id: id, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }

    func getCatalogData(page: Int, category: Int, completionHandler: @escaping (RequestResult<[Product]>) -> Void) {
        let requestModel = CatalogData(baseURL: self.baseURL, page: page, category: category, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
}

extension Goods {
    struct ProductById: RequestRouter {
        var baseURL: String
        let path = "/product"
        let id: Int
        let method: RequestRouterMethod
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "id_product", value: String(id))]
        }
        let data: Data? = nil
    }

    struct CatalogData: RequestRouter {
        var baseURL: String
        let path = "/catalog"
        let page: Int
        let category: Int
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "page_number", value: String(page)),
                    URLQueryItem(name: "id_category", value: String(category))
            ]
        }
        let method: RequestRouterMethod
        let data: Data? = nil
    }
}
