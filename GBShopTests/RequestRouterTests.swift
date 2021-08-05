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
    let method: RequestRouterMethod
}

class RequestRouterTests: XCTestCase {
    
    func testRequestRouter_withInvalidPath_throwsErrors() throws {
        let request = Request(baseURL: "https://yandex.ru", path: "login", queryItems: nil, method: .get)
        XCTAssertThrowsError(try request.asURLRequest())
    }
    
    func testRequestRouter_withInvalidBaseURL_throwsErrors() throws {
        let request = Request(baseURL: "234234", path: "lo2345gin", queryItems: nil, method: .get)
        XCTAssertThrowsError(try request.asURLRequest())
    }
    
    func testRequestRouter_withValidRequest_throwNoErrors() throws {
        let expectedRequest = URLRequest(url: URL(string: "https://yandex.ru/login?username=Somebody&password=mypassword")!)
        let request = Request(baseURL: "https://yandex.ru",
                              path: "/login",
                              queryItems: [URLQueryItem(name: "username", value: "Somebody"),
                                           URLQueryItem(name: "password", value: "mypassword")],
                              method: .get)
        let result = try? request.asURLRequest()
        XCTAssertEqual(result, expectedRequest)
        
    }
}
