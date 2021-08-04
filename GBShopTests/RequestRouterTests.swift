//
//  RequestRouterTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 04.08.2021.
//

import XCTest
@testable import GBShop

struct Request: RequestRouter {
    let scheme: String
    let host: String
    let path: String
    var queryItems: [URLQueryItem]?
    let method: RequestRouterMethod
    let encoding: RequestRouterEncoding
}

class RequestRouterTests: XCTestCase {
    
    var invalidRequest: Request!
    var correctRequest: Request!
    
    override func setUpWithError() throws {
        invalidRequest = Request(scheme: "https", host: "yandex.ru", path: "login", queryItems: nil, method: .get, encoding: .url)
        let queryItems = [URLQueryItem(name: "username", value: "Somebody"),
                    URLQueryItem(name: "password", value: "mypassword")]
        correctRequest = Request(scheme: "https", host: "yandex.ru", path: "/login", queryItems: queryItems, method: .get, encoding: .url)
    }

    override func tearDownWithError() throws {
        invalidRequest = nil
        correctRequest = nil
    }

    func testThrowErrorForInvalidURLComponents() throws {
        XCTAssertThrowsError(try invalidRequest.asURLRequest())
    }
    
    func testURLRequest() throws {
        let expectedRequest = URLRequest(url: URL(string: "https://yandex.ru/login?username=Somebody&password=mypassword")!)
        
        let result = try? correctRequest.asURLRequest()
        XCTAssertEqual(result, expectedRequest)
        
    }
}
