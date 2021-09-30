//
//  ReviewsRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 21.08.2021.
//

import Foundation

protocol ReviewsRequestFactory {
    func getReviewsForProduct(id: Int, completionHandler: @escaping (AbstractResult<ReviewResponse>) -> Void)
    func addReview(userId: Int, productId: Int, review: Review, completionHandler: @escaping (AbstractResult<StandardResult>) -> Void)
    func removeReview(id: Int, completionHandler: @escaping (AbstractResult<StandardResult>) -> Void)
}
