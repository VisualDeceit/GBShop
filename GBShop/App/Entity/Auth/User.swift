//
//  User.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

enum UserGender: String {
    case male = "m"
    case female = "f"
}

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }
    
    let id: Int
    let login: String
    let name: String
    let lastname: String
}
