//
//  RequestFactoryTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 22.08.2021.
//

import XCTest
@testable import GBShop

class RequestFactoryTests: XCTestCase {
    var requestFactory: RequestFactory!

    override func setUp() {
        requestFactory = RequestFactory()
    }

    override func tearDown() {
        requestFactory = nil
    }
    
    func testMakeAuthRequestFatory() {
        let auth = requestFactory.makeAuthRequestFatory()
        XCTAssertTrue((auth as Any) is AuthRequestFactory)
    }
    
    func testMakeGoodsRequestFatory() {
        let goods = requestFactory.makeGoodsRequestFatory()
        XCTAssertTrue((goods as Any) is GoodsRequestFactory)
    }
    
    func testMakeReviewsRequestFatory() {
        let review = requestFactory.makeReviewsRequestFatory()
        XCTAssertTrue((review as Any) is ReviewsRequestFactory)
    }
    
    func testMakeErrorParser() {
        let error = requestFactory.makeErrorParser()
        XCTAssertTrue((error as Any) is AbstractErrorParser)
    }
}
