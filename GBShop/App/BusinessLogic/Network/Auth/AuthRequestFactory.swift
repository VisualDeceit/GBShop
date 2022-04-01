//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AbstractResult<LoginResult>) -> Void)

    func logout(id: Int, completionHandler: @escaping (AbstractResult<LogoutResult>) -> Void)

    func registerUser(id: Int,
                      userName: String,
                      password: String,
                      email: String,
                      gender: UserGender,
                      creditCard: String,
                      bio: String,
                      completionHandler: @escaping (AbstractResult<RegisterUserResult>) -> Void)

    func changeUserData(id: Int,
                        userName: String,
                        password: String,
                        email: String,
                        gender: UserGender,
                        creditCard: String,
                        bio: String,
                        completionHandler: @escaping (AbstractResult<ChangeUserDataResult>) -> Void)
}
