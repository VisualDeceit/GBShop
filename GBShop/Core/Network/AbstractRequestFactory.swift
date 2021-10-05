//
//  AbstractRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

protocol AbstractRequestFactory {
    var baseURL: String { get }
    var networkService: NetworkServiceProtocol { get }

    func request<T: Decodable>(request: RequestRouter, complitionHandler: @escaping (RequestResult<T>) -> Void)
}

extension AbstractRequestFactory {
    public func request<T: Decodable>(request: RequestRouter, complitionHandler: @escaping (RequestResult<T>) -> Void) {
            return networkService.makeRequest(request: request, completion: complitionHandler)   
    }
}
