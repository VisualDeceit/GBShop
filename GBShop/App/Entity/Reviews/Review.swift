//
//  Review.swift
//  GBShop
//
//  Created by Alexander Fomin on 21.08.2021.
//

import Foundation

struct Review: Codable {
    let caption: String
    let date: Int
    let rating: Int
    let comment: String
}
