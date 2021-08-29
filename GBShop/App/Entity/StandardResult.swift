//
//  StandardResult.swift
//  GBShop
//
//  Created by Alexander Fomin on 21.08.2021.
//

import Foundation

struct StandardResult: Codable {
    enum CodingKeys: String, CodingKey {
        case result
        case message = "user_message"
        case error = "error_meessage"
    }
    
    let result: Int
    var message: String?
    var error: String?
}
