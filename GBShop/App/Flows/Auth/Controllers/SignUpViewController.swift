//
//  SignUpViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 01.09.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var onDismiss: (() -> Void)?
    
    private var signUpView: SignUpView {
        // swiftlint:disable force_cast
        self.view as! SignUpView
        // swiftlint:enable force_cast
    }

    override func loadView() {
        self.view = SignUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.signUpView.scrollView.addGestureRecognizer(hideKeyboardGesture)
        self.signUpView.signUpButton.addTarget(self, action: #selector(createNewUser), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotification()
        }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // modal presentations have changed in iOS 13, viewWillAppear is not called when modals are dismissed
        self.onDismiss?()
    }
    
    @objc func createNewUser() {
        dismiss(animated: true)
    }
    
    // MARK: - Notifications
    private func subscribeToNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Keyboard functions
    @objc func hideKeyboard() {
        self.signUpView.endEditing(true)
    }

    @objc func keyboardWasShown(notification: Notification) {
        if let userInfo = notification.userInfo,
           let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] {
            let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
            let keyboardOverlap = endRect.height + self.view.safeAreaInsets.bottom + self.view.safeAreaInsets.top
            self.signUpView.scrollView.contentInset.bottom = keyboardOverlap
            self.signUpView.scrollView.verticalScrollIndicatorInsets.bottom = keyboardOverlap
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        self.signUpView.scrollView.contentInset = .zero
    }
}
