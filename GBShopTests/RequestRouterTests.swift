//
//  RequestRouterTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 05.08.2021.
//

import XCTest
@testable import GBShop

class RequestRouterTests: XCTestCase {
    
    struct Request: RequestRouter {
        let baseURL: String
        let path: String
        var queryItems: [URLQueryItem]?
        let data: Data?
        let method: RequestRouterMethod
    }

    func testWhenInvalidURLThenThrowError() throws {
        let host = "https://xxxxx."
        let getMethod = Request(baseURL: host, path: "", queryItems: nil, data: nil, method: .get)
        XCTAssertThrowsError(try getMethod.asURLRequest(), "Expected to be a failure but got a success") { error in
            XCTAssertEqual(error as? RequestRouterError, RequestRouterError.invalidURL, "Expected to be a failure with error 'invalidURL' but got a '\(error)'")
        }
    }
    
    func testGetMethodWhenInvalidPathThenThrowError() throws {
        let host = "https://xxxxx.xx"
        let path = "path"
        let getMethod = Request(baseURL: host, path: path, queryItems: nil, data: nil, method: .get)
        XCTAssertThrowsError(try getMethod.asURLRequest(), "Expected to be a failure but got a success") { error in
            XCTAssertEqual(error as? RequestRouterError, RequestRouterError.invalidPath, "Expected to be a failure with error 'invalidPath' but got a '\(error)'")
        }
    }
    
    func testPostMethodWhenInvalidPathThenThrowError() throws {
        let host = "https://xxxxx.xx"
        let path = "path"
        let postMethod = Request(baseURL: host, path: path, queryItems: nil, data: nil, method: .post)
        XCTAssertThrowsError(try postMethod.asURLRequest(), "Expected to be a failure but got a success") { error in
            XCTAssertEqual(error as? RequestRouterError, RequestRouterError.invalidPath, "Expected to be a failure with error 'invalidPath' but got a '\(error)'")
        }
    }
    
    func testGetMethodWhenValidRequestThenReturn() throws {
        // swiftlint:disable force_unwrapping
        var expectedRequest = URLRequest(url: URL(string: "https://xxxxx.xx/path?a=1&b=2")!)
        expectedRequest.httpMethod = "GET"
        // swiftlint:enable force_unwrapping
        let request = Request(baseURL: "https://xxxxx.xx",
                              path: "/path",
                              queryItems: [URLQueryItem(name: "a", value: "1"),
                                           URLQueryItem(name: "b", value: "2")],
                              data: nil,
                              method: .get)
        let result = try? request.asURLRequest()
        XCTAssertEqual(result, expectedRequest)
    }
    
    func testPotsMethodWithQueryItemWhenValidRequestThenReturn() throws {
        // swiftlint:disable force_unwrapping
        var expectedRequest = URLRequest(url: URL(string: "https://xxxxx.xx/path")!)
        // swiftlint:enable force_unwrapping
        let parameters = "{\n\"a\" : \"1\",\n\"b\" : \"2\"\n}"
        let postData = parameters.data(using: .utf8)
        expectedRequest.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        expectedRequest.httpMethod = "POST"
        expectedRequest.httpBody = postData
        
        let request = Request(baseURL: "https://xxxxx.xx",
                              path: "/path",
                              queryItems: [URLQueryItem(name: "a", value: "1"),
                                           URLQueryItem(name: "b", value: "2")],
                              data: nil,
                              method: .post)
        let result = try? request.asURLRequest()
        XCTAssertEqual(result, expectedRequest)
    }
    
    func testPotsMethodWithDataValidRequestThenReturn() throws {
        // swiftlint:disable force_unwrapping
        var expectedRequest = URLRequest(url: URL(string: "https://xxxxx.xx/path")!)
        // swiftlint:enable force_unwrapping
        let parameters = "{\n\"a\" : \"1\",\n\"b\" : \"2\"\n}"
        let postData = parameters.data(using: .utf8)
        expectedRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        expectedRequest.httpMethod = "POST"
        expectedRequest.httpBody = postData
        
        let request = Request(baseURL: "https://xxxxx.xx",
                              path: "/path",
                              data: postData,
                              method: .post)
        let result = try? request.asURLRequest()
        XCTAssertEqual(result, expectedRequest)
    }
}
