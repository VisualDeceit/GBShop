//
//  RegisterUserResult.swift
//  GBShop
//
//  Created by Alexander Fomin on 28.07.2021.
//

import Foundation

struct RegisterUserResult: Codable {
    let result: Int
    let userMessage: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
    }
}
