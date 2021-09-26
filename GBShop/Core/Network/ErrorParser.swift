//
//  ErrorParser.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }

    func parse(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        return error
    }
}
