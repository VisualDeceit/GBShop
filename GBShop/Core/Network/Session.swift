//
//  Session.swift
//  GBShop
//
//  Created by Alexander Fomin on 04.09.2021.
//

import Foundation

class Session {
    
    private init() {}
    
    static let shared = Session()
    var userId: Int? = 1
}
