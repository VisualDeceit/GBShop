//
//  ReviewsTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 22.08.2021.
//

import XCTest
@testable import GBShop

class ReviewsTests: XCTestCase {
    let baseUrl = "https://failUrl"
    var commonSession: URLSession!
    var errorParser: ErrorParserStub!
    var expectation: XCTestExpectation!
    var reviews: Reviews!

    override func setUp() {
        super.setUp()
        errorParser = ErrorParserStub()
        expectation = XCTestExpectation(description: "Download timout")
        commonSession = {
            let configuration = URLSessionConfiguration.default
            configuration.httpShouldSetCookies = false
            configuration.httpAdditionalHeaders = .none
            let manager = URLSession(configuration: configuration)
            return manager
        }()
        reviews = Reviews(errorParser: errorParser, sessionManager: commonSession)
    }

    override func tearDown() {
        super.tearDown()
        commonSession = nil
        errorParser = nil
        reviews = nil
    }
    
    func testGetReviewsForProduct_whenBaseURLCorrect_throwsNoErrors() {
        reviews.getReviewsForProduct(id: 1) { [weak self] result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testGetReviewsForProduct_withInvalidURL_throwsErrors() throws {
        reviews.baseURL = self.baseUrl
        reviews.getReviewsForProduct(id: 123) { [weak self] result in
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure:
                XCTAssertTrue(true)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testaAddReview_whenBaseURLCorrect_throwsNoErrors() {
        let review = Review(caption: "Test", date: 1629584374, rating: 3, comment: "Test comment")
        reviews.addReview(userId: 1, productId: 1, review: review) { [weak self] result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testaAddReview_withInvalidURL_throwsErrors() throws {
        reviews.baseURL = self.baseUrl
        let review = Review(caption: "Test", date: 1629584374, rating: 3, comment: "Test comment")
        reviews.addReview(userId: 1, productId: 1, review: review) { [weak self] result in
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure:
                XCTAssertTrue(true)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testRemoveReview_whenBaseURLCorrect_throwsNoErrors() {
        reviews.removeReview(id: 1) { [weak self] result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testGetReview_withInvalidURL_throwsErrors() throws {
        reviews.baseURL = self.baseUrl
        reviews.removeReview(id: 123) { [weak self] result in
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure:
                XCTAssertTrue(true)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
