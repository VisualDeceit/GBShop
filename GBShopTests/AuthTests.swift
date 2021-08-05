//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 05.08.2021.
//

import XCTest
@testable import GBShop

class AuthTests: XCTestCase {
    
    var auth: Auth!
    var commonSession: URLSession!
    var errorParser: ErrorParserStub!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        commonSession = {
            let configuration = URLSessionConfiguration.default
            configuration.httpShouldSetCookies = false
            configuration.httpAdditionalHeaders = .none
            let manager = URLSession(configuration: configuration)
            return manager
        }()
        errorParser = ErrorParserStub()
        auth = Auth(errorParser: errorParser, sessionManager: commonSession)
        expectation = XCTestExpectation(description: "Download timout")
    }

    override func tearDown() {
        super.tearDown()
        commonSession = nil
        errorParser = nil
        auth = nil
    }

    func testLogin_WithBaseURL_ThrowsNoErrors() throws {
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

}
