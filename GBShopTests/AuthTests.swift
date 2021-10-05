//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Alexander Fomin on 05.08.2021.
//

import XCTest
@testable import GBShop

final class NetworkServiceSpy<Model: Decodable>: NetworkServiceProtocol {
    var requestStub: ((RequestRouter, (RequestResult<Model>) -> Void) -> Void)?
    
    func makeRequest<T>(request: RequestRouter, completion: @escaping (Result<T, NetworkServiceErrors>) -> Void) where T : Decodable {
        requestStub?(request, completion)
    }
}

class AuthTests: XCTestCase {
    let baseUrl = "https://failUrl"
    var commonSession: URLSession!
    var expectation = XCTestExpectation(description: "Download timout")
    
    private lazy var networkSpyService = NetworkServiceSpy<LoginResult>()
    private lazy var SUTAuth = Auth(networkService: networkSpyService)
    
    func testGivenRequestWhenLoginThenCompliteWithResult() {
        var request: RequestRouter?
        networkSpyService.requestStub = { recievedRequest, completion in
            request = recievedRequest
            completion(.success(.init(result: 1,
                                      user: User(id: 1,
                                                 login: "test@mail.com",
                                                 name: "name",
                                                 lastname: "lastname"))))
        }
        
        var loginResult: LoginResult?
        SUTAuth.login(userName: "user", password: "password") { (requestResult) in
            loginResult = try? requestResult.get()
        }
    }
}
