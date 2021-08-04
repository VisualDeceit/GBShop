//
//  RequestRouter.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

enum RequestRouterEncoding {
    case url, json
}

enum RequestRouterMethod: String {
    case get = "GET"
    case post = "POST"
}

enum RequestRouterError: Error {
    case invalidURLComponent(URLComponents)
}

protocol RequestRouter {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: RequestRouterMethod { get }
    var encoding: RequestRouterEncoding { get }
}

extension RequestRouter {
    func asURLRequest() throws -> URLRequest {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems

        guard let fullURL = urlComponent.url else {
            throw RequestRouterError.invalidURLComponent(urlComponent)
        }
        
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

