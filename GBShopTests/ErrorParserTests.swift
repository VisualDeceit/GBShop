//
//  ErrorParserTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 05.08.2021.
//

import XCTest
@testable import GBShop

enum ErrorStub: LocalizedError {
    case fatalError
}

class ErrorParserTests: XCTestCase {
    let errorParser = ErrorParser()
    
    var thrownError: Error?

    func testParser() throws {
        let error = errorParser.parse(ErrorStub.fatalError) as! ErrorStub
        XCTAssertEqual(error, ErrorStub.fatalError)
    }
    
    func testParserReturnNil() throws {
        XCTAssertNil(errorParser.parse(data: nil, response: nil, error: nil))
    }
}
