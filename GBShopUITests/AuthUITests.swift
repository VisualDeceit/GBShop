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
    }

    override func tearDownWithError() throws {
    }

    func testLoginFailed() {
        let app = XCUIApplication()
        app.launch()
        
        let loginView = app.otherElements["LoginView"].firstMatch
        XCTAssertTrue(loginView.waitForExistence(timeout: 1))
        
        let loginButton = loginView.buttons["loginButton"].firstMatch
        XCTAssertTrue(loginButton.waitForExistence(timeout: 1))
        loginButton.tap()
        
        let elementsQuery = app.alerts["Ошибка"].scrollViews.otherElements
        elementsQuery.buttons["Повторить"].tap()
        elementsQuery.buttons["Отменить"].tap()
        
        XCTAssertNotNil(elementsQuery)
    }
    
    func testLoginSuccesed() {
        let app = XCUIApplication()
        app.launch()
        
        let loginView = app.otherElements["LoginView"].firstMatch
        XCTAssertTrue(loginView.waitForExistence(timeout: 1))
        
        let loginTextField = loginView.textFields["loginTextField"].firstMatch
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 1))
        loginTextField.tap()
        loginTextField.typeText("test@mail.com")
        
        let passwordTextField = loginView.textFields["passwordTextField"].firstMatch
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 1))
        passwordTextField.tap()
        passwordTextField.typeText("000000")
        
        let loginButton = loginView.buttons["loginButton"].firstMatch
        XCTAssertTrue(loginButton.waitForExistence(timeout: 1))
        loginButton.tap()
        
        let signUpView = app.otherElements["SignUpView"].firstMatch
        XCTAssertTrue(signUpView.waitForExistence(timeout: 5))
        
        let signUpButton = signUpView.buttons["signUpButton"].firstMatch
        XCTAssertTrue(signUpButton.waitForExistence(timeout: 1))
        signUpButton.tap()
        
        let logoutButton = signUpView.buttons["logoutButton"].firstMatch
        XCTAssertTrue(logoutButton.waitForExistence(timeout: 1))
        logoutButton.tap()

        XCTAssert(loginView.waitForExistence(timeout: 5))
    }
    
    func testSignUp() {
        let app = XCUIApplication()
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Cоздайте новый."]/*[[".buttons[\"Cоздайте новый.\"].staticTexts[\"Cоздайте новый.\"]",".staticTexts[\"Cоздайте новый.\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Создать"]/*[[".scrollViews.buttons[\"Создать\"]",".buttons[\"Создать\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Создать"].tap()
        XCTAssert(app/*@START_MENU_TOKEN@*/.textFields["имя пользователя"]/*[[".scrollViews.textFields[\"имя пользователя\"]",".textFields[\"имя пользователя\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 3))
    }
}
