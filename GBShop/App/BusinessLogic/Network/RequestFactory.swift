//
//  RequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

class RequestFactory {

    lazy var commonSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = .none
        let manager = URLSession(configuration: configuration)
        return manager
    }()

    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }

    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession)
    }

    func makeGoodsRequestFatory() -> GoodsRequestFactory {
        let errorParser = makeErrorParser()
        return Goods(errorParser: errorParser, sessionManager: commonSession)
    }
    
    func makeReviewsRequestFatory() -> ReviewsRequestFactory {
        let errorParser = makeErrorParser()
        return Reviews(errorParser: errorParser, sessionManager: commonSession)
    }
}
