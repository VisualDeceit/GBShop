//
//  AnalyticsFacade.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.09.2021.
//

import Foundation
import FirebaseAnalytics

class AnalyticsFacade {
    static func removeFromCart(item: CartItem) {
        Analytics.logEvent(AnalyticsEventRemoveFromCart, parameters: [
            AnalyticsParameterItems: [[
                                        AnalyticsParameterItemName: item.product.name,
                                        "quantity": item.quantity]] as NSArray,
            AnalyticsParameterValue: (item.product.price * item.quantity)  as NSNumber,
            AnalyticsParameterCurrency: "RUB" as NSString
        ])
    }

    static func purchase() {
        Analytics.logEvent(AnalyticsEventPurchase, parameters: [
            AnalyticsParameterItems: Purchase.cart.items.map {[
                AnalyticsParameterItemName: $0.product.name,
                "quantity": $0.quantity]
            } as NSArray,
            AnalyticsParameterValue: Purchase.cart.total as NSNumber,
            AnalyticsParameterCurrency: "RUB" as NSString
        ])
    }
    
    static func addReview(item: Review) {
        Analytics.logEvent("new_review", parameters: [
            "caption": item.caption as NSObject,
            "date": item.date as NSInteger,
            "rating": item.rating as NSInteger,
            "comment": item.comment as NSString
        ])
    }
    
    static func getCatalogList(items: [Product]) {
        Analytics.logEvent(AnalyticsEventViewItemList, parameters: [
            AnalyticsParameterItems: items.map {
                [AnalyticsParameterItemName: $0.name]
            } as NSArray
        ])
    }
    
    static func getProductDetail(item: ProductResult) {
        Analytics.logEvent(AnalyticsEventViewItem, parameters: [
            AnalyticsParameterItemName: item.name  as NSString,
            AnalyticsParameterValue: item.price as NSNumber
        ])
    }
    
    static func addToCart(item: ProductResult) {
        Analytics.logEvent(AnalyticsEventAddToCart,
                           parameters: [
                            AnalyticsParameterItemName: item.name as NSString,
                            AnalyticsParameterValue: item.price as NSNumber
                           ])
    }
    
    static func loginFailure(login: String?, reason: String?) {
        Analytics.logEvent("login_failure",
                           parameters: [
                            "login": login ?? "" as NSObject,
                            "message": reason ?? "" as NSObject
                           ])
    }
    
    static func login(login: String?) {
        Analytics.logEvent(AnalyticsEventLogin,
                           parameters: [
                            AnalyticsParameterItemName: login ?? "default" as NSObject
                           ])
    }
    
    static func singUp(login: String?) {
        Analytics.logEvent(AnalyticsEventSignUp,
                           parameters: [
                            AnalyticsParameterItemName: login ?? "" as NSObject
                           ])
    }
    
    static func logout(login: String?) {
        Analytics.logEvent("logout",
                           parameters: [
                            "login": login ?? "" as NSObject
                           ])
    }
}
