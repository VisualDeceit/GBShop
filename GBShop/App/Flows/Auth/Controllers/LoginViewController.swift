//
//  LoginViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.08.2021.
//

import UIKit
import FirebaseAnalytics

class LoginViewController: UIViewController {
    
    private let requestFactory: RequestFactory
    private let authRequestFactory: AuthRequestFactory
    private var loginView = LoginView()
    
    init(with requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        authRequestFactory = requestFactory.makeAuthRequestFatory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        loginView.scrollView.addGestureRecognizer(hideKeyboardGesture)
        loginView.loginButton.addTarget(self, action: #selector(onLoginButtonPressed), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(onSignupButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotification()
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
    }
    
    // MARK: - Button targets
    @objc func onLoginButtonPressed() {
        authRequestFactory.login(userName: loginView.loginTextField.text ?? "", password: loginView.passwordTextField.text ?? "") { [weak self] response in
           switch response {
           case .success(let answer):
            if answer.result == 0 {
                Analytics.logEvent("login_failure", parameters: [
                    "login": self?.loginView.loginTextField.text ?? "" as NSObject,
                    "message": answer.message ?? "" as NSObject
                ])
                let alert = UIAlertController(title: "Ошибка", message: answer.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Отменить", style: .cancel))
                alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: { _ in
                    self?.onLoginButtonPressed()
                }))
                self?.present(alert, animated: true)
            } else {
                Analytics.logEvent(AnalyticsEventLogin,
                                   parameters: [
                                    AnalyticsParameterItemName: answer.user?.login ?? "default" as NSObject
                                   ])
                Session.shared.userId = answer.user?.id
                // сохраняем ссылку на tabBarController
                if let tabbarC = self?.tabBarController,
                   let self = self {
                    // так как после удаления  контроллера self?.tabBarController == nil
                    tabbarC.viewControllers?.removeLast()
                    let accountViewController = SignUpViewController(type: .changeUserData("Личные данные", "Изменить"), requestFactory: self.requestFactory)
                    accountViewController.user = answer.user
                    accountViewController.tabBarItem = UITabBarItem(title: "Кабинет", image: UIImage(systemName: "person"), tag: 0)
                    tabbarC.viewControllers?.append(accountViewController)
                    tabbarC.selectedIndex = (tabbarC.viewControllers?.count ?? 1) - 1
                }
            }
           case .failure(let error):
            print(error.localizedDescription)
           }
       }
    }
    
    @objc func onSignupButtonPressed() {
        let signUpViewController = SignUpViewController(type: .signUp("Новый аккаунт", "Создать"), requestFactory: self.requestFactory)
        present(signUpViewController, animated: true) { [weak self] in
            self?.unsubscribeFromNotifications()
        }
        
        signUpViewController.onDismiss = { [weak self] in
            self?.subscribeToNotification()
        }
    }
    
    // MARK: - Notifications
    private func subscribeToNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Private functions
    private func setupView() {
        self.loginView.loginTextField.setUnderLine()
        self.loginView.passwordTextField.setUnderLine()
        self.loginView.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: self.loginView.signUpStackView.frame.origin.y + 16)
    }
    
    // MARK: - Keyboard functions
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
