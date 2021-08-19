//
//  GoodsTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 08.08.2021.
//

import XCTest
@testable import GBShop

class GoodsTests: XCTestCase {
    let baseUrl = "https://failUrl"
    var commonSession: URLSession!
    var errorParser: ErrorParserStub!
    var expectation: XCTestExpectation!
    var goods: Goods!

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
        goods = Goods(errorParser: errorParser, sessionManager: commonSession)
    }

    override func tearDown() {
        super.tearDown()
        commonSession = nil
        errorParser = nil
        goods = nil
    }

    func testGetProductByID_whenBaseURLCorrect_throwsNoErrors() {
        goods.getProductById(id: 123) { [weak self] result in
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

    func testGetProductByID_withInvalidURL_throwsErrors() throws {
        goods.baseURL = self.baseUrl
        goods.getProductById(id: 123) { [weak self] result in
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

    func testGetCatalogData_whenBaseURLCorrect_throwsNoErrors() {
        goods.getCatalogData(page: 1, category: 1) { [weak self] result in
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

    func testGetCatalogData_withInvalidURL_throwsErrors() throws {
        goods.baseURL = self.baseUrl
        goods.getCatalogData(page: 1, category: 1) { [weak self] result in
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
