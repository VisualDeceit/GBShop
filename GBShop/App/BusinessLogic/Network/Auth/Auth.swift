//
//  Auth.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

enum Constants {
    static let baseURL = //"https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses"
    "http://127.0.0.1:8080"
}

class Auth: AbstractRequestFactory {
    var baseURL: String
    var errorParser: AbstractErrorParser
    var sessionManager: URLSession
  
    init(baseURL: String, errorParser: AbstractErrorParser, sessionManager: URLSession) {
        self.baseURL = baseURL
        self.errorParser = errorParser
        self.sessionManager = sessionManager
    }
    
    convenience init(errorParser: AbstractErrorParser, sessionManager: URLSession) {
        self.init(baseURL: Constants.baseURL, errorParser: errorParser, sessionManager: sessionManager)
    }
}

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (Result<LoginResult, Error>) -> Void) {
        let requestModel = Login(baseURL: self.baseURL, login: userName, password: password, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func logout(id: Int, completionHandler: @escaping (Result<LogoutResult, Error>) -> Void) {
        let requestModel = Logout(baseURL: self.baseURL, id: 123, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func registerUser(id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String, completionHandler: @escaping (Result<RegisterUserResult, Error>) -> Void) {
        let requestModel = RegisterUser(baseURL: self.baseURL, id: id, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func changeUserData(id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String, completionHandler: @escaping (Result<ChangeUserDataResult, Error>) -> Void) {
        let requestModel = ChangeUserData(baseURL: self.baseURL, id: id, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        var baseURL: String
        let path = "/login.json"
        let login: String
        let password: String
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "username", value: login),
                    URLQueryItem(name: "password", value: password)]
        }
        let method: RequestRouterMethod
    }
    
    struct Logout: RequestRouter {
        var baseURL: String
        let path = "/logout.json"
        let id: Int
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "id_use", value: String(id)),
            ]
        }
        let method: RequestRouterMethod
    }
    
    class RegisterUser: UserData, RequestRouter {
        var baseURL: String
        let path = "/register"
        let method: RequestRouterMethod = .post
        
        init(baseURL: String, id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String) {
            self.baseURL = baseURL
            super.init(id: id, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        }
    }
    
    class ChangeUserData: UserData, RequestRouter {
        var baseURL: String
        let path = "/changeUserData.json"
        let method: RequestRouterMethod = .get
        let encoding: RequestRouterEncoding = .url
        
        init(baseURL: String, id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String) {
            self.baseURL = baseURL
            super.init(id: id, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        }
    }
}
