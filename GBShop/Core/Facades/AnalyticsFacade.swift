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
            AnalyticsParameterValue: Purchase.total as NSNumber,
            AnalyticsParameterCurrency: "RUB" as NSString
        ])
    }
}
