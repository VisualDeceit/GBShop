//
//  DataRequestTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 04.08.2021.
//

import XCTest
@testable import GBShop

struct PostStub: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct InvalidPostStub: Codable {
    let userid: Int
    let isdfd: Int
    let tidfdstle: String
    let boddsfy: String
}

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStub: AbstractErrorParser {
    func parse(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        return error
    }

    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
}

struct ValidRequestStub: RequestRouter {
    let baseURL = "https://jsonplaceholder.typicode.com"
    let path = "/posts/1"
    var queryItems: [URLQueryItem]?
    let data: Data? = nil
    let method: RequestRouterMethod = .get
}

struct InvalidHostStub: RequestRouter {
    let baseURL = "https://jsonplaceholder.typicode.ru"
    let path = "/posts/1"
    var queryItems: [URLQueryItem]?
    let data: Data? = nil
    let method: RequestRouterMethod = .get
}

struct InvalidRequestStub: RequestRouter {
    let baseURL = "https://jsonplaceholder.typicode.ru"
    let path = "posts/1"
    var queryItems: [URLQueryItem]?
    let data: Data? = nil
    let method: RequestRouterMethod = .get
}

// struct InvalidRequestStub: RequestRouter {
//    let baseURL = "https://jsonplaceholder.typicode.ru"
//    let path = "posts/1"
//    var queryItems: [URLQueryItem]?
//    let method: RequestRouterMethod = .get
// }

class DataRequestTests: XCTestCase {

    var expectation: XCTestExpectation!
    var errorParser: ErrorParserStub!

    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation(description: "Download timout")
        errorParser = ErrorParserStub()
    }

    override func tearDown() {
        super.tearDown()
        expectation = nil
        errorParser = nil
    }

    func testResponseData_whenValidRequest_throwsNoErrors() throws {
        let request = ValidRequestStub()
        URLSession.shared.responseData(errorParser: errorParser,
                                       request: request) { [weak self] (response: Result<PostStub, Error>) in
            switch response {
            case .success:
                XCTAssert(true)
            case .failure(let error):
                XCTFail("Expected to be a success but got a failure with \(error)")
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testResponseData_whenHostNotFound_throwsErrors() throws {
        let request = InvalidHostStub()
        URLSession.shared.responseData(errorParser: errorParser,
                                       request: request) { [weak self] (response: Result<PostStub, Error>) in
            switch response {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure:
                XCTAssert(true)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testResponseData_whenInvalidURL_throwsErrors() throws {
        let request = InvalidRequestStub()
        URLSession.shared.responseData(errorParser: errorParser,
                                       request: request) { [weak self] (response: Result<InvalidPostStub, Error>) in
            switch response {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure:
                XCTAssert(true)
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
