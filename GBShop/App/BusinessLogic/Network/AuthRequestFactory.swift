//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (Result<LoginResult, Error>) -> Void)
}
