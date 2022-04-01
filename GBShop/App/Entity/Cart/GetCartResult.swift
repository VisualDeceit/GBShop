//
//  GetCartResult.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.09.2021.
//

import Foundation

struct GetCartResult: Codable {
    enum CodingKeys: String, CodingKey {
        case items
        case result
        case errorMessage = "error_meessage"
    }
    
    let result: Int
    var errorMessage: String?
    var items: [CartItem]?
}
