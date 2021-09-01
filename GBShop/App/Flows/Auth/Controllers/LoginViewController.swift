//
//  LoginViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginView: LoginView {
        // swiftlint:disable force_cast
        self.view as! LoginView
        // swiftlint:enable force_cast
    }

    // MARK: - Lifecycle
    override func loadView() {
        self.view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardToolbar()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.loginView.scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    // MARK: - Keyboard functions
    private func addKeyboardToolbar() {
        let keyboardToolbar = UIToolbar()
            keyboardToolbar.sizeToFit()
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(hideKeyboard))
            keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.loginView.loginTextField.inputAccessoryView = keyboardToolbar
        self.loginView.passwordTextField.inputAccessoryView = keyboardToolbar
    }
    
    @objc func hideKeyboard() {
        self.loginView.endEditing(true)
    }

    @objc func keyboardWasShown(notification: Notification) {
        if let userInfo = notification.userInfo,
           let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] {
            let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
            let keyboardOverlap = endRect.height + self.view.safeAreaInsets.bottom + self.view.safeAreaInsets.top
            self.loginView.scrollView.contentInset.bottom = keyboardOverlap
            self.loginView.scrollView.verticalScrollIndicatorInsets.bottom = keyboardOverlap
            let bottomOffset = CGPoint(x: 0, y: self.loginView.scrollView.contentSize.height - self.loginView.scrollView.bounds.height + keyboardOverlap)
            self.loginView.scrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        self.loginView.scrollView.contentInset = .zero
    }
}
