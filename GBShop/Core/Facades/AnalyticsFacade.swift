//
//  AnalyticsFacade.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.09.2021.
//

import Foundation
import FirebaseAnalytics

protocol AnalyticsFacadeProtocol {
    func login(login: String?)
    func loginFailure(login: String?, reason: String?)
    func logout(login: String?)
    func singUp(login: String?)
    
    func getCatalogList(items: [Product])
    func getProductDetail(item: ProductResult)
    
    func addToCart(item: ProductResult)
    func removeFromCart(item: CartItem)
    func purchase()
    
    func addReview(item: Review) 
}

struct AnalyticsFacade: AnalyticsFacadeProtocol {
    static let shared = AnalyticsFacade()
    
    private init() {}
    
    func removeFromCart(item: CartItem) {
        Analytics.logEvent(AnalyticsEventRemoveFromCart, parameters: [
            AnalyticsParameterItems: [[
                                        AnalyticsParameterItemName: item.product.name,
                                        "quantity": item.quantity]] as NSArray,
            AnalyticsParameterValue: (item.product.price * item.quantity)  as NSNumber,
            AnalyticsParameterCurrency: "RUB" as NSString
        ])
    }

    func purchase() {
        Analytics.logEvent(AnalyticsEventPurchase, parameters: [
            AnalyticsParameterItems: Purchase.cart.items.map {[
                AnalyticsParameterItemName: $0.product.name,
                "quantity": $0.quantity]
            } as NSArray,
            AnalyticsParameterValue: Purchase.cart.total as NSNumber,
            AnalyticsParameterCurrency: "RUB" as NSString
        ])
    }
    
    func addReview(item: Review) {
        Analytics.logEvent("new_review", parameters: [
            "caption": item.caption as NSObject,
            "date": item.date as NSInteger,
            "rating": item.rating as NSInteger,
            "comment": item.comment as NSString
        ])
    }
    
    func getCatalogList(items: [Product]) {
        Analytics.logEvent(AnalyticsEventViewItemList, parameters: [
            AnalyticsParameterItems: items.map {
                [AnalyticsParameterItemName: $0.name]
            } as NSArray
        ])
    }
    
    func getProductDetail(item: ProductResult) {
        Analytics.logEvent(AnalyticsEventViewItem, parameters: [
            AnalyticsParameterItemName: item.name  as NSString,
            AnalyticsParameterValue: item.price as NSNumber
        ])
    }
    
    func addToCart(item: ProductResult) {
        Analytics.logEvent(AnalyticsEventAddToCart,
                           parameters: [
                            AnalyticsParameterItemName: item.name as NSString,
                            AnalyticsParameterValue: item.price as NSNumber
                           ])
    }
    
    func loginFailure(login: String?, reason: String?) {
        Analytics.logEvent("login_failure",
                           parameters: [
                            "login": login ?? "" as NSObject,
                            "message": reason ?? "" as NSObject
                           ])
    }
    
    func login(login: String?) {
        Analytics.logEvent(AnalyticsEventLogin,
                           parameters: [
                            AnalyticsParameterItemName: login ?? "default" as NSObject
                           ])
    }
    
    func singUp(login: String?) {
        Analytics.logEvent(AnalyticsEventSignUp,
                           parameters: [
                            AnalyticsParameterItemName: login ?? "" as NSObject
                           ])
    }
    
    func logout(login: String?) {
        Analytics.logEvent("logout",
                           parameters: [
                            "login": login ?? "" as NSObject
                           ])
    }
}
