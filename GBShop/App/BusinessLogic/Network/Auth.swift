//
//  Auth.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

class Auth: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: URLSession
  
    init(errorParser: AbstractErrorParser, sessionManager: URLSession) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
    }
}

extension Auth {
    struct Login: RequestRouter {
        let scheme = "https"
        let host = "raw.githubusercontent.com"
        let path = "/GeekBrainsTutorial/online-store-api/master/responses/login.json"
        let login: String
        let password: String
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "username", value: login),
                    URLQueryItem(name: "password", value: password)]
        }
        let method: RequestRouterMethod = .get
        let encoding: RequestRouterEncoding = .url
    }
}

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (Result<LoginResult, Error>) -> Void) {
        let requestMode = Login(login: userName, password: password)
        self.request(request: requestMode, complitionHandler: completionHandler)
    }
}
