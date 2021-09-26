//
//  DataRequest.swift
//  GBShop
//
//  Created by Alexander Fomin on 28.07.2021.
//

import Foundation

protocol DataRequest {
    func loadData<T: Decodable>(errorParser: AbstractErrorParser,
                                request: URLRequest,
                                completion: @escaping (Result<T, Error>) -> Void)
}

extension URLSession: DataRequest {
    func loadData<T>(errorParser: AbstractErrorParser,
                     request: URLRequest,
                     completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        self.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = errorParser.parse(data: data, response: response, error: error) {
                    completion(.failure(error))
                }
                do {
                    // swiftlint:disable force_unwrapping
                    let value = try JSONDecoder().decode(T.self, from: data!)
                    // swiftlint:enable force_unwrapping
                    completion(Result { value })
                } catch {
                    let customError = errorParser.parse(error)
                    completion(.failure(customError))
                }
            }
        }.resume()
    }
}
