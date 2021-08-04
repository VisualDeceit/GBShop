//
//  Auth.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

enum BaseUrl {
    static let host = "raw.githubusercontent.com"
    static let path = "/GeekBrainsTutorial/online-store-api/master/responses/"
}

class Auth: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: URLSession
  
    init(errorParser: AbstractErrorParser, sessionManager: URLSession) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
    }
}

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (Result<LoginResult, Error>) -> Void) {
        let requestModel = Login(login: userName, password: password)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func logout(id: Int, completionHandler: @escaping (Result<LogoutResult, Error>) -> Void) {
        let requestModel = Logout(id: 123)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func registerUser(id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String, completionHandler: @escaping (Result<RegisterUserResult, Error>) -> Void) {
        let requestModel = RegisterUser(id: id, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func changeUserData(id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String, completionHandler: @escaping (Result<ChangeUserDataResult, Error>) -> Void) {
        let requestModel = ChangeUserData(id: id, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let scheme = "https"
        let host = BaseUrl.host
        let path = BaseUrl.path + "login.json"
        let login: String
        let password: String
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "username", value: login),
                    URLQueryItem(name: "password", value: password)]
        }
        let method: RequestRouterMethod = .get
        let encoding: RequestRouterEncoding = .url
    }
    
    struct Logout: RequestRouter {
        let scheme = "https"
        let host = BaseUrl.host
        let path = BaseUrl.path + "logout.json"
        let id: Int
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "id_use", value: String(id)),
            ]
        }
        let method: RequestRouterMethod = .get
        let encoding: RequestRouterEncoding = .url
    }
    
    class RegisterUser: UserData, RequestRouter {
        let scheme = "https"
        let host = BaseUrl.host
        let path = BaseUrl.path + "registerUser.json"
        let method: RequestRouterMethod = .get
        let encoding: RequestRouterEncoding = .url
    }
    
    class ChangeUserData: UserData, RequestRouter {
        let scheme = "https"
        let host = BaseUrl.host
        let path = BaseUrl.path + "changeUserData.json"
        let method: RequestRouterMethod = .get
        let encoding: RequestRouterEncoding = .url
    }
}
