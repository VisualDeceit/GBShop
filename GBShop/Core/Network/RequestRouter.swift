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
    case invalidBaseURL(String)
}

protocol RequestRouter {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: RequestRouterMethod { get }
    var encoding: RequestRouterEncoding { get }
}

extension RequestRouter {
    func asURLRequest() throws -> URLRequest {
        guard var urlComponent = URLComponents(string: baseURL)  else {
            throw RequestRouterError.invalidBaseURL(baseURL)
        }
        //путь всегда добавляем в конец
        urlComponent.path = urlComponent.path + path
        urlComponent.queryItems = queryItems

        guard let fullURL = urlComponent.url else {
            throw RequestRouterError.invalidURLComponent(urlComponent)
        }
        
        var urlRequest = URLRequest(url: fullURL)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

