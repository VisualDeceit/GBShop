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
    
    func testLogout_withBaseURL_throwsNoErrors() throws {
        let auth = Auth(errorParser: errorParser, sessionManager: commonSession)
        auth.logout(id: 123) {[weak self] result in
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
    
    func testLogout_withInvalidURL_throwsErrors() throws {
        let baseUrl = "https://failUrl"
        let auth = Auth(baseURL: baseUrl, errorParser: errorParser, sessionManager: commonSession)
        auth.logout(id: 123) {[weak self] result in
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
    
    func testRegisterUser_withBaseURL_throwsNoErrors() throws {
        let auth = Auth(errorParser: errorParser, sessionManager: commonSession)
        auth.registerUser(id: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: UserGender.male, creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {[weak self] result in
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
    
    func testRegisterUser_withInvalidURL_throwsErrors() throws {
        let baseUrl = "https://failUrl"
        let auth = Auth(baseURL: baseUrl, errorParser: errorParser, sessionManager: commonSession)
        auth.registerUser(id: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: UserGender.male, creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {[weak self] result in
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
    
    func testChangeUserData_withBaseURL_throwsNoErrors() throws {
        let auth = Auth(errorParser: errorParser, sessionManager: commonSession)
        auth.changeUserData(id: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: UserGender.male, creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {[weak self] result in
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
    
    func testChangeUserData_withInvalidURL_throwsErrors() throws {
        let baseUrl = "https://failUrl"
        let auth = Auth(baseURL: baseUrl, errorParser: errorParser, sessionManager: commonSession)
        auth.changeUserData(id: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: UserGender.male, creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {[weak self] result in
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
