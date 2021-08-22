//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

protocol AbstractRequestFactory {
    var baseURL: String { get }
    var errorParser: AbstractErrorParser { get }
    var sessionManager: URLSession { get }

    func request<T: Decodable>(request: RequestRouter, complitionHandler: @escaping (Result<T, Error>) -> Void)
}

extension AbstractRequestFactory {
    public func request<T: Decodable>(request: RequestRouter, complitionHandler: @escaping (Result<T, Error>) -> Void) {
        return sessionManager.responseData(errorParser: errorParser, request: request, completion: complitionHandler)
    }
}
