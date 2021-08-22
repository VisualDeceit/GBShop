//
//  RequestRouterTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 05.08.2021.
//

import XCTest
@testable import GBShop

struct Request: RequestRouter {
    let baseURL: String
    let path: String
    var queryItems: [URLQueryItem]?
    let data: Data?
    let method: RequestRouterMethod
}

struct PostRequest: RequestRouter {
    let baseURL: String
    let path: String = "/add_review"
    let userId: Int
    let productId: Int
    var queryItems: [URLQueryItem]?
    let data: Data?
    var method: RequestRouterMethod = .post
}

class RequestRouterTests: XCTestCase {

    func testRequestRouter_withGetMethodAndInvalidPath_throwsErrors() throws {
        let getRequest = Request(baseURL: "https://yandex.ru", path: "login", queryItems: nil, data: nil, method: .get)
        XCTAssertThrowsError(try getRequest.asURLRequest())
    }

    func testRequestRouter_withInvalidBaseURL_throwsErrors() throws {
        let getRequest = Request(baseURL: "234234", path: "lo2345gin", queryItems: nil, data: nil, method: .get)
        XCTAssertThrowsError(try getRequest.asURLRequest())
    }
    

    func testRequestRouter_withValidRequest_throwNoErrors() throws {
        // swiftlint:disable force_unwrapping
        let expectedRequest = URLRequest(url: URL(string: "https://ya.ru/login?username=Somebody&password=mypassword")!)
        // swiftlint:enable force_unwrapping
        let request = Request(baseURL: "https://ya.ru",
                              path: "/login",
                              queryItems: [URLQueryItem(name: "username", value: "Somebody"),
                                           URLQueryItem(name: "password", value: "mypassword")],
                              data: nil,
                              method: .get)
        let result = try? request.asURLRequest()
        XCTAssertEqual(result, expectedRequest)
    }
    
    func testRequestRouter_withPostMethodAndInvalidPath_throwsErrors() throws {
        let postRequest = Request(baseURL: "https://yandex.ru", path: "login", queryItems: nil, data: nil, method: .post)
        XCTAssertThrowsError(try postRequest.asURLRequest())
    }
    
    func testRequesrRouter_withPostMethod_throwNoErrors() throws {
        let review = Review(caption: "Test", date: 1629584374, rating: 3, comment: "Test comment")
        let requestBody = AddReviewRequestBody(userId: 767, productId: 1, review: review)
        do {
            let reviewData = try JSONEncoder().encode(requestBody)
            let postRequest = PostRequest(baseURL: Constants.baseURL, userId: 767, productId: 1, data: reviewData)
            XCTAssertNoThrow(try postRequest.asURLRequest())
        } catch {
            XCTFail("Encode error \(error)")
        }
    }
}
