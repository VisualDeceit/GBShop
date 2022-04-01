//
//  UserData.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.07.2021.
//

import Foundation

protocol UserData {
    var id: Int { get set }
    var userName: String { get set }
    var password: String { get set }
    var email: String { get set }
    var gender: UserGender { get set }
    var creditCard: String { get set }
    var bio: String { get set }
}

extension UserData {
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "id_user", value: String(id)),
        URLQueryItem(name: "username", value: userName),
        URLQueryItem(name: "password", value: password),
        URLQueryItem(name: "email", value: email),
        URLQueryItem(name: "gender", value: gender.rawValue),
        URLQueryItem(name: "credit_card", value: password),
        URLQueryItem(name: "bio", value: password)
        ]
    }
}
