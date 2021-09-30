//
//  GoodsRequestFactory.swift
//  GBShop
//
//  Created by Alexander Fomin on 07.08.2021.
//

import Foundation

protocol GoodsRequestFactory {
    func getProductById(id: Int, completionHandler: @escaping (AbstractResult<ProductResult>) -> Void)
    func getCatalogData(page: Int, category: Int, completionHandler: @escaping (AbstractResult<[Product]>) -> Void)
}
