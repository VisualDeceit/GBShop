//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (Result<LoginResult, Error>) -> Void)
    func registerUser(id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String, completionHandler: @escaping (Result<RegisterUserResult, Error>) -> Void)
    func logout(id: Int, completionHandler: @escaping (Result<LogoutResult, Error>) -> Void)
    func changeUserData(id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String, completionHandler: @escaping (Result<ChangeUserDataResult, Error>) -> Void)
}


