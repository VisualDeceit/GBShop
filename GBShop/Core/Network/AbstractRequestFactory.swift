//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: URLSession { get }
    func request<T: Decodable>(request: RequestRouter, complitionHandler: @escaping (Result<T, Error>) -> ())
}

extension AbstractRequestFactory {
    public func request<T: Decodable>(request: RequestRouter, complitionHandler: @escaping (Result<T, Error>) -> ()) {
        return sessionManager.responseData(errorParser: errorParser, request: request, completion: complitionHandler)
    }
}
