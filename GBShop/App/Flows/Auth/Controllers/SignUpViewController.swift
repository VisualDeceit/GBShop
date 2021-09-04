//
//  SignUpViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 01.09.2021.
//

import UIKit

enum ControllerType {
    case signUp(String, String)
    case changeUserData(String, String)
}

class SignUpViewController: UIViewController {
    
    var onDismiss: (() -> Void)?
    
    private var type: ControllerType
    private var caption: String
    private var buttonText: String
    
    private var signUpView: SignUpView {
        // swiftlint:disable force_cast
        self.view as! SignUpView
        // swiftlint:enable force_cast
    }
    
    init(type: ControllerType) {
        self.type = type
        switch type {
        
        case let .signUp (caption, buttonText):
            self.caption = caption
            self.buttonText = buttonText
        case let .changeUserData(caption, buttonText):
            self.caption = caption
            self.buttonText = buttonText
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = SignUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.signUpView.scrollView.addGestureRecognizer(hideKeyboardGesture)
        self.signUpView.signUpButton.addTarget(self, action: #selector(createNewUser), for: .touchUpInside)
        self.signUpView.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotification()
        }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.onDismiss?()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
    }
    
    // MARK: - Notifications
    private func subscribeToNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Private functions
    private func setupView() {
        self.signUpView.captionLabel.text = self.caption
        self.signUpView.signUpButton.setTitle(self.buttonText, for: .normal)
        self.signUpView.loginTextField.setUnderLine()
        self.signUpView.passwordTextField.setUnderLine()
        self.signUpView.emailTextField.setUnderLine()
        self.signUpView.creditCardTextField.setUnderLine()
        self.signUpView.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: self.signUpView.signUpButton.frame.origin.y + 32)
        
        self.signUpView.logoutButton.isHidden = Session.shared.userId == nil
    }
    
    @objc func createNewUser() {
        dismiss(animated: true)
    }
    
    @objc func logout() {
        Session.shared.userId = nil
        if let tabbarController = self.view.window?.rootViewController as? UITabBarController {
            tabbarController.viewControllers?.remove(at: 0)
            let accountViewController = LoginViewController()
            accountViewController.tabBarItem = UITabBarItem(title: "Кабинет", image: UIImage(systemName: "person"), tag: 0)
            tabbarController.setViewControllers([accountViewController], animated: false)
        }
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
