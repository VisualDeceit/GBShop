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
    
    let requestFactory: RequestFactory
    let authRequestFactory: AuthRequestFactory
    
    var user: User? {
        didSet {
            if let user = user {
                self.signUpView.populate(user: user)
            }
        }
    }
    
    private var type: ControllerType
    private var caption: String
    private var buttonText: String
    private var signUpView: SignUpView {
        // swiftlint:disable force_cast
        self.view as! SignUpView
        // swiftlint:enable force_cast
    }
    
    init(type: ControllerType, requestFactory: RequestFactory) {
        self.type = type
        
        switch type {
        case let .signUp (caption, buttonText):
            self.caption = caption
            self.buttonText = buttonText
        case let .changeUserData(caption, buttonText):
            self.caption = caption
            self.buttonText = buttonText
        }
        
        self.requestFactory = requestFactory
        authRequestFactory = requestFactory.makeAuthRequestFatory()
        
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
        self.signUpView.signUpButton.addTarget(self, action: #selector(actionWithUser), for: .touchUpInside)
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
        signUpView.captionLabel.text = self.caption
        signUpView.signUpButton.setTitle(self.buttonText, for: .normal)
        signUpView.loginTextField.setUnderLine()
        signUpView.passwordTextField.setUnderLine()
        signUpView.emailTextField.setUnderLine()
        signUpView.creditCardTextField.setUnderLine()
        signUpView.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: signUpView.signUpButton.frame.origin.y + 32)
        
        signUpView.logoutButton.isHidden = Session.shared.userId == nil
    }
    
    @objc func actionWithUser() {
        let gender: UserGender
        if signUpView.genderSegmentedControl.selectedSegmentIndex == 0 {
            gender = .male
        } else {
            gender = .female
        }
        
        switch type {
        case .signUp:
            authRequestFactory.registerUser(id: 123,
                                            userName: signUpView.loginTextField.text ?? "",
                                            password: signUpView.passwordTextField.text ?? "",
                                            email: signUpView.emailTextField.text ?? "",
                                            gender: gender,
                                            creditCard: signUpView.creditCardTextField.text ?? "",
                                            bio: signUpView.bioTextView.text ?? "") { [weak self] response in
                switch response {
                case .success(let answer):
                    print(answer)
                    self?.dismiss(animated: true)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .changeUserData:
            authRequestFactory.changeUserData(id: 123,
                                              userName: signUpView.loginTextField.text ?? "",
                                              password: signUpView.passwordTextField.text ?? "",
                                              email: signUpView.emailTextField.text ?? "",
                                              gender: gender,
                                              creditCard: signUpView.creditCardTextField.text ?? "",
                                              bio: signUpView.bioTextView.text ?? "") { response in
                switch response {
                case .success(let answer):
                    print(answer)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @objc func logout() {
        authRequestFactory.logout(id: Session.shared.userId ?? 0) { [weak self] response in
            switch response {
            case .success(let answer):
                print(answer)
                Session.shared.userId = nil
                // сохраняем ссылку на tabBarController
                if let tabbarC = self?.tabBarController,
                let self = self {
                    // так как после удаления  контроллера self?.tabBarController == nil
                    tabbarC.viewControllers?.removeLast()
                    let accountViewController = LoginViewController(with: self.requestFactory)
                    accountViewController.tabBarItem = UITabBarItem(title: "Кабинет", image: UIImage(systemName: "person"), tag: 0)
                    tabbarC.viewControllers?.append(accountViewController)
                    tabbarC.selectedIndex = (tabbarC.viewControllers?.count ?? 1) - 1
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
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
