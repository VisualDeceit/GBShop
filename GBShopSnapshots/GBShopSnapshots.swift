//
//  GBShopSnapshots.swift
//  GBShopSnapshots
//
//  Created by Alexander Fomin on 04.10.2021.
//

import XCTest

class GBShopSnapshots: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
                app.launch()
        snapshot("0Launch")
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["tbCatalog"].tap()
        snapshot("1Catalog")
        
        app.collectionViews.cells.containing(.staticText, identifier: "Sony Playstation 5").element.tap()
        snapshot("2ProductDetail")
        
        app.buttons["addToCartButton"].firstMatch.tap()
        tabBar.buttons["tbCart"].tap()
        snapshot("3Cart")
    }
}
