//
//  AddReviewRequestBody.swift
//  GBShop
//
//  Created by Alexander Fomin on 21.08.2021.
//

import Foundation

struct AddReviewRequestBody: Codable {
    enum CodingKeys: String, CodingKey {
        case userId = "id_user"
        case productId = "id_product"
        case review
    }
    
    let userId: Int
    let productId: Int
    let review: Review
}
