//
//  CartTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 29.08.2021.
//

import XCTest
@testable import GBShop

class CartTests: XCTestCase {
    let baseUrl = "https://failUrl"
    var commonSession: URLSession!
    var errorParser: ErrorParserStub!
    var expectation: XCTestExpectation!
    var cart: Cart!

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
        cart = Cart(errorParser: errorParser, sessionManager: commonSession)
    }

    override func tearDown() {
        super.tearDown()
        commonSession = nil
        errorParser = nil
        cart = nil
    }
    
    func testAddToCartProduct_whenBaseURLCorrect_throwsNoErrors() {
        cart.addToCartProduct(id: 1, quantity: 1) { [weak self] result in
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

    func testAddToCartProduct_withInvalidURL_throwsErrors() throws {
        cart.baseURL = self.baseUrl
        cart.addToCartProduct(id: 1, quantity: 1) { [weak self] result in
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

    func testRemoveFromCartProduct_whenBaseURLCorrect_throwsNoErrors() {
        cart.removeFromCartProduct(id: 1) { [weak self] result in
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

    func testRemoveFromCartProduct_withInvalidURL_throwsErrors() throws {
        cart.baseURL = self.baseUrl
        cart.removeFromCartProduct(id: 1) { [weak self] result in
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
    
    func testPayCart_whenBaseURLCorrect_throwsNoErrors() {
        cart.payCart { [weak self] result in
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

    func testPayCart_withInvalidURL_throwsErrors() throws {
        cart.baseURL = self.baseUrl
        cart.payCart { [weak self] result in
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
