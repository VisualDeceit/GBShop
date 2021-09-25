//
//  LoginResult.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

struct LoginResult: Codable {
    enum CodingKeys: String, CodingKey {
        case result
        case user
        case message = "error_message"
    }
    
    let result: Int
    var user: User?
    var message: String?
}
