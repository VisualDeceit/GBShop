//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 05.08.2021.
//

import XCTest
@testable import GBShop

class AuthTests: XCTestCase {
    
    var commonSession: URLSession!
    var errorParser: ErrorParserStub!
    var expectation: XCTestExpectation!
    
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
    }

    override func tearDown() {
        super.tearDown()
        commonSession = nil
        errorParser = nil
    }

    func testLogin_withBaseURL_throwsNoErrors() throws {
        let auth = Auth(errorParser: errorParser, sessionManager: commonSession)
        auth.login(userName: "test", password: "password") {[weak self] result in
            switch result {
            case .success(_):
                XCTAssertTrue(true)
            case .failure(_):
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testLogin_withInvalidURL_throwsErrors() throws {
        let baseUrl = "https://failUrl"
        let auth = Auth(baseURL: baseUrl, errorParser: errorParser, sessionManager: commonSession)
        auth.login(userName: "test", password: "password") {[weak self] result in
            switch result {
            case .success(_):
                XCTFail("Expected error")
            case .failure(_):
                XCTAssertTrue(true)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
