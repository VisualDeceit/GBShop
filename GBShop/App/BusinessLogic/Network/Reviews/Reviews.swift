//
//  Reviews.swift
//  GBShop
//
//  Created by Alexander Fomin on 21.08.2021.
//

import Foundation

final class Reviews: AbstractRequestFactory {
    var baseURL: String
    var errorParser: AbstractErrorParser
    var sessionManager: URLSession
    
    init(baseURL: String, errorParser: AbstractErrorParser, sessionManager: URLSession) {
        self.baseURL = baseURL
        self.errorParser = errorParser
        self.sessionManager = sessionManager
    }

    convenience init(errorParser: AbstractErrorParser, sessionManager: URLSession) {
        self.init(baseURL: Constants.baseURL, errorParser: errorParser, sessionManager: sessionManager)
    }
}

extension Reviews {
    struct ReviewsForProduct: RequestRouter {
        var baseURL: String
        let path = "/reviews"
        let id: Int
        let method: RequestRouterMethod
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "id_product", value: String(id))]
        }
        let data: Data? = nil
    }
    
    struct AddReview: RequestRouter {
        let baseURL: String
        let path: String = "/add_review"
        let userId: Int
        let productId: Int
        var queryItems: [URLQueryItem]?
        let data: Data?
        var method: RequestRouterMethod
    }
    
    struct RemoveReview: RequestRouter {
        let baseURL: String
        let path: String = "/remove_review"
        let commentId: Int
        var queryItems: [URLQueryItem]? {
            return [URLQueryItem(name: "id_comment", value: String(commentId))]
        }
        let data: Data? = nil
        var method: RequestRouterMethod
    }
}

extension Reviews: ReviewsRequestFactory {
    func getReviewsForProduct(id: Int, completionHandler: @escaping (AbstractResult<ReviewResponse>) -> Void) {
        let requestModel = ReviewsForProduct(baseURL: self.baseURL, id: id, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func addReview(userId: Int, productId: Int, review: Review, completionHandler: @escaping (AbstractResult<StandardResult>) -> Void) {
        let requestBody = AddReviewRequestBody(userId: userId, productId: productId, review: review)
        let reviewData = try? JSONEncoder().encode(requestBody)
        let requestModel = AddReview(baseURL: self.baseURL, userId: userId, productId: productId, data: reviewData, method: .post)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
    
    func removeReview(id: Int, completionHandler: @escaping (AbstractResult<StandardResult>) -> Void) {
        let requestModel = RemoveReview(baseURL: self.baseURL, commentId: id, method: .get)
        self.request(request: requestModel, complitionHandler: completionHandler)
    }
}
