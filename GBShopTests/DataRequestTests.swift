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

struct LoginStub: RequestRouter {
    let scheme = "https"
    let host = "failUrl"
    let path = ""
    var queryItems: [URLQueryItem]?
    let method: RequestRouterMethod = .get
    let encoding: RequestRouterEncoding = .url
}

class DataRequestTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser: ErrorParserStub!
    let login = LoginStub()

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
     
    }

    func testURLSessionResponseData() throws {
        errorParser = ErrorParserStub()
        URLSession.shared.responseData(errorParser: errorParser, request: login) { [weak self] (response: Result<PostStub, Error>) in
            switch response {
            case .success(_):
                break
            case .failure(_):
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
