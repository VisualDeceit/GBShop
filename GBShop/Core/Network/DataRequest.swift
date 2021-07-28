//
//  DataRequest.swift
//  GBShop
//
//  Created by Alexander Fomin on 28.07.2021.
//

import Foundation

protocol DataRequest {
    func responseData<T: Decodable>(errorParser: AbstractErrorParser, request: URLRequest, completion: @escaping (Result<T, Error>) -> ())
}

extension URLSession: DataRequest {
    func responseData<T>(errorParser: AbstractErrorParser, request: URLRequest, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        self.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = errorParser.parse(data: data, response: response, error: error) {
                    completion(.failure(error))
                }
                do {
                    let value = try JSONDecoder().decode(T.self, from: data!)
                    completion(Result{value})
                }
                catch {
                    let customError = errorParser.parse(error)
                    completion(.failure(customError))
                }
            }
        }.resume()
    }
}
