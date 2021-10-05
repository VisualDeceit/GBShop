//
//  Auth.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

final class Auth: AbstractRequestFactory {
    var baseURL: String
    var networkService: NetworkServiceProtocol

    init(baseURL: String, networkService: NetworkServiceProtocol) {
        self.baseURL = baseURL
        self.networkService = networkService
    }

    convenience init(networkService: NetworkServiceProtocol) {
        self.init(baseURL: Constants.baseURL, networkService: networkService)
    }
}

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (RequestResult<LoginResult>) -> Void) {
        let requestModel = Login(baseURL: self.baseURL, login: userName, password: password, method: .post)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }

    func logout(id: Int, completionHandler: @escaping (RequestResult<LogoutResult>) -> Void) {
        let requestModel = Logout(baseURL: self.baseURL, id: 123, method: .post)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }

    func registerUser(id: Int,
                      userName: String,
                      password: String,
                      email: String,
                      gender: UserGender,
                      creditCard: String,
                      bio: String,
                      completionHandler: @escaping (RequestResult<RegisterUserResult>) -> Void) {
        let requestModel = RegisterUser(id: id, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio, baseURL: self.baseURL, method: .post)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }

    func changeUserData(id: Int,
                        userName: String,
                        password: String,
                        email: String,
                        gender: UserGender,
                        creditCard: String,
                        bio: String,
                        completionHandler: @escaping (RequestResult<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserData(id: id, userName: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio, baseURL: self.baseURL, method: .post)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        var baseURL: String
        let path = "/login"
        let login: String
        let password: String
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "username", value: login),
                    URLQueryItem(name: "password", value: password)]
        }
        let method: RequestRouterMethod
        let data: Data? = nil
    }

    struct Logout: RequestRouter {
        var baseURL: String
        let path = "/logout"
        let id: Int
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "id_user", value: String(id))
            ]
        }
        let method: RequestRouterMethod
        let data: Data? = nil
    }
    
    struct RegisterUser: UserData, RequestRouter {
        var id: Int
        var userName: String
        var password: String
        var email: String
        var gender: UserGender
        var creditCard: String
        var bio: String
        var baseURL: String
        var path = "/register"
        var method: RequestRouterMethod
        var data: Data?
    }
    
    struct ChangeUserData: UserData, RequestRouter {
        var id: Int
        var userName: String
        var password: String
        var email: String
        var gender: UserGender
        var creditCard: String
        var bio: String
        var baseURL: String
        var path = "/change_user"
        var method: RequestRouterMethod
        var data: Data?
    }
}
