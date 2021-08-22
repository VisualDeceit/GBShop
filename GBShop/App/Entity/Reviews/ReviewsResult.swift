//
//  ReviewsResult.swift
//  GBShop
//
//  Created by Alexander Fomin on 21.08.2021.
//

import Foundation

struct ReviewResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case reviews
        case result
        case errorMessage = "error_meessage"
    }
    
    let reviews: [Review]
    var result: Int?
    var errorMessage: String?
}
