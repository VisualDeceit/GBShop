//
//  RequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

class RequestFactory {

//    lazy var commonSession: URLSession = {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpShouldSetCookies = false
//        configuration.httpAdditionalHeaders = .none
//        let manager = URLSession(configuration: configuration)
//        return manager
//    }()
    let commonSession = NetworkService()

    func makeAuthRequestFatory() -> AuthRequestFactory {
        return Auth(networkService: commonSession)
    }

    func makeGoodsRequestFatory() -> GoodsRequestFactory {
        return Goods(networkService: commonSession)
    }
    
    func makeReviewsRequestFatory() -> ReviewsRequestFactory {
        return Reviews(networkService: commonSession)
    }
    
    func makeCartRequestFatory() -> CartRequestFactory {
        return Cart(networkService: commonSession)
    }
}
