//
//  AuthUITests.swift
//  GBShopUITests
//
//  Created by Alexander Fomin on 25.09.2021.
//

import XCTest

class AuthUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
    }

    func testAuthFailed() {
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["Войти"]/*[[".scrollViews.buttons[\"Войти\"]",".buttons[\"Войти\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Войти"].tap()
        
        let elementsQuery = app.alerts["Ошибка"].scrollViews.otherElements
        elementsQuery.buttons["Повторить"].tap()
        elementsQuery.buttons["Отменить"].tap()
        XCTAssertNotNil(elementsQuery)
    }
    
    func testAuthSuccesed() {
        let app = XCUIApplication()
        let loginTextField = app/*@START_MENU_TOKEN@*/.textFields["имя пользователя"]/*[[".scrollViews.textFields[\"имя пользователя\"]",".textFields[\"имя пользователя\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        loginTextField.tap()
        loginTextField.typeText("test@mail.com")

        let passwordTextField = app.textFields["пароль"]
        passwordTextField.tap()
        passwordTextField.typeText("000000")
        app/*@START_MENU_TOKEN@*/.buttons["Войти"]/*[[".scrollViews.buttons[\"Войти\"]",".buttons[\"Войти\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Войти"].tap()    
    }
}
