//
//  RequestRouter.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

enum Constants {
    static let baseURL = "https://gb-shop.herokuapp.com"
}

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
}

extension RequestRouter {
    func asURLRequest() throws -> URLRequest {
        guard var urlComponent = URLComponents(string: baseURL),
              (urlComponent.scheme == "http" || urlComponent.scheme == "https") else {
            throw RequestRouterError.invalidBaseURL(baseURL)
        }
        // путь всегда добавляем в конец
        urlComponent.path += path

        switch method {
        case .get:
            urlComponent.queryItems = queryItems
            guard let fullURL = urlComponent.url else {
                throw RequestRouterError.invalidURLComponent(urlComponent)
            }
            var urlRequest = URLRequest(url: fullURL)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        case .post:
            guard let fullURL = urlComponent.url else {
                throw RequestRouterError.invalidURLComponent(urlComponent)
            }
            var urlRequest = URLRequest(url: fullURL)
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            urlComponent.queryItems = queryItems
            urlRequest.httpBody = urlComponent.percentEncodedQuery?.data(using: .utf8)
            return urlRequest
        }
    }
}
