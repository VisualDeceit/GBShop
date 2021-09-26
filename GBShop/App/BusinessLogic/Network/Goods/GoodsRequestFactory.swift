//
//  GoodsRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 07.08.2021.
//

import Foundation

protocol GoodsRequestFactory {
    func getProductById(id: Int, completionHandler: @escaping (Result<ProductResult, Error>) -> Void)
    func getCatalogData(page: Int, category: Int, completionHandler: @escaping (Result<[Product], Error>) -> Void)
}
