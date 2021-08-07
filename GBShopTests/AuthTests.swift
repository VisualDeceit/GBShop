//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 05.08.2021.
//

import XCTest
@testable import GBShop

class AuthTests: XCTestCase {
    let baseUrl = "https://failUrl"
    var commonSession: URLSession!
    var errorParser: ErrorParserStub!
    var expectation: XCTestExpectation!
    var auth: Auth!

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
        auth = Auth(errorParser: errorParser, sessionManager: commonSession)
    }

    override func tearDown() {
        super.tearDown()
        commonSession = nil
        errorParser = nil
    }

    func testLogin_withBaseURL_throwsNoErrors() throws {
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
        auth.baseURL = self.baseUrl
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
        auth.baseURL = self.baseUrl
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
        auth.baseURL = self.baseUrl
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
        auth.changeUserData(id: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: UserGender.male, creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") {[weak self] result in
            switch result {
            case .success(_):
                XCTAssertTrue(true)
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testChangeUserData_withInvalidURL_throwsErrors() throws {
        auth.baseURL = self.baseUrl
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        
        auth.changeUserData(id: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru", gender: UserGender.male, creditCard: "9872389-2424-234224-234", bio: "This is good! I think I will switch to another language") { [weak self] result in
            sceneDelegate.changeUserDataResultCallback(result)
            switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(_):
                XCTAssertTrue(true)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20)
    }
}
