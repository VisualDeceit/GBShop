//
//  NetworkService.swift
//  GBShop
//
//  Created by Alexander Fomin on 28.07.2021.
//

import Foundation

enum NetworkServiceErrors: Error {
    case invalidRequest
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

typealias RequestResult<T> = Result<T, NetworkServiceErrors> where T: Decodable

protocol NetworkServiceProtocol {
    associatedtype Model
    func makeRequest(request: RequestRouter,
                                       completion: @escaping (Result<Model, NetworkServiceErrors>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
 
    typealias Model = LoginResult
    
    func makeRequest<Model>(request: RequestRouter, completion: @escaping (RequestResult<Model>) -> Void) where Model: Decodable {

        guard let request = try? request.asURLRequest() else {
            completion(.failure(.invalidRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.clientError))
                    return
                }
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    completion(.failure(.serverError))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let decodedData = try? JSONDecoder().decode(Model.self, from: data) else {
                    completion(.failure(.dataDecodingError))
                    return
                }
                completion(.success(decodedData))
            }
        }.resume()
    }
}
