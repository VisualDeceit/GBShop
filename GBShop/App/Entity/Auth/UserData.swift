//
//  UserData.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.07.2021.
//

import Foundation

class UserData {
    var id: Int = 0
    var userName: String = ""
    var password: String = ""
    var email: String = ""
    var gender: UserGender = .male
    var creditCard: String = ""
    var bio: String = ""
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "id_use", value: String(id)),
        URLQueryItem(name: "username", value: userName),
        URLQueryItem(name: "password", value: password),
        URLQueryItem(name: "email", value: email),
        URLQueryItem(name: "gender", value: gender.rawValue),
        URLQueryItem(name: "credit_card", value: password),
        URLQueryItem(name: "bio", value: password),
        ]
    }
    
    init(id: Int, userName: String, password: String, email: String, gender: UserGender, creditCard: String, bio: String) {
        self.id = id
        self.userName = userName
        self.password = password
        self.email = email
        self.gender = gender
        self.creditCard = creditCard
        self.bio = bio
    }
}
