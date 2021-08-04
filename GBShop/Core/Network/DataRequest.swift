//
//  DataRequest.swift
//  GBShop
//
//  Created by Alexander Fomin on 28.07.2021.
//

import Foundation

protocol DataRequest {
    func responseData<T: Decodable>(errorParser: AbstractErrorParser, request: RequestRouter, completion: @escaping (Result<T, Error>) -> ())
}

extension URLSession: DataRequest {
    func responseData<T>(errorParser: AbstractErrorParser, request: RequestRouter, completion: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        do {
            let urlRequest =  try request.asURLRequest()
            
            self.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = errorParser.parse(data: data, response: response, error: error) {
                        completion(.failure(error))
                    }
                    do {
                        guard let data = data else { throw error!}
                        let value = try JSONDecoder().decode(T.self, from: data)
                        completion(Result{value})
                    }
                    catch {
                        let customError = errorParser.parse(error)
                        completion(.failure(customError))
                    }
                }
            }.resume()
        }
        catch {
            completion(.failure(error))
        }
    }
}
