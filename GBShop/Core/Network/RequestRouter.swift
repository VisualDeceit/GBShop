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
    case invalidURL
    case invalidPath
}

protocol RequestRouter {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestRouterMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var data: Data? { get }
}

extension RequestRouter {
    
    func asURLRequest() throws -> URLRequest {
        guard var urlComponent = URLComponents(string: baseURL),
              (urlComponent.scheme == "http" || urlComponent.scheme == "https"),
              let domainName = urlComponent.host,
              domainName.components(separatedBy: ".").count > 1,
              let topLevelDomain = domainName.components(separatedBy: ".").last,
              !topLevelDomain.isEmpty
        else {
            throw RequestRouterError.invalidURL
        }

        urlComponent.path += path
        
        switch method {
        case .get:
            urlComponent.queryItems = queryItems
            guard let fullURL = urlComponent.url else {
                throw RequestRouterError.invalidPath
            }
            var urlRequest = URLRequest(url: fullURL)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        case .post:
            guard let fullURL = urlComponent.url else {
                throw RequestRouterError.invalidPath
            }
            
            var urlRequest = URLRequest(url: fullURL)
            urlRequest.httpMethod = method.rawValue
            
            if let data = self.data {
                urlRequest.httpBody = data
                urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            } else {
                urlComponent.queryItems = queryItems
                urlRequest.httpBody = urlComponent.percentEncodedQuery?.data(using: .utf8)
                urlRequest.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            }
            return urlRequest
        }
    }
}
