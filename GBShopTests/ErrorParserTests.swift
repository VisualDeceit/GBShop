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
        // swiftlint:disable force_cast
        let error = errorParser.parse(ErrorStub.fatalError) as! ErrorStub
        // swiftlint:enable force_cast
        XCTAssertEqual(error, ErrorStub.fatalError)
    }

    func testParserReturnNil() throws {
        XCTAssertNil(errorParser.parse(data: nil, response: nil, error: nil))
    }
}
