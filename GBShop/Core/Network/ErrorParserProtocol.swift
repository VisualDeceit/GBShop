//
//  ErrorParserProtocol.swift
//  GBShop
//
//  Created by Alexander Fomin on 26.07.2021.
//

import Foundation

protocol ErrorParserProtocol {
    func parse(_ result: Error) -> Error
    func parse(data: Data?, response: URLResponse?, error: Error?) -> Error?
}
