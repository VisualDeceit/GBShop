//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (RequestResult<LoginResult>) -> Void)

    func logout(id: Int, completionHandler: @escaping (RequestResult<LogoutResult>) -> Void)

    func registerUser(id: Int,
                      userName: String,
                      password: String,
                      email: String,
                      gender: UserGender,
                      creditCard: String,
                      bio: String,
                      completionHandler: @escaping (RequestResult<RegisterUserResult>) -> Void)

    func changeUserData(id: Int,
                        userName: String,
                        password: String,
                        email: String,
                        gender: UserGender,
                        creditCard: String,
                        bio: String,
                        completionHandler: @escaping (RequestResult<ChangeUserDataResult>) -> Void)
}
