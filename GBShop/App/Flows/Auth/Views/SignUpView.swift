//
//  SignUpView.swift
//  GBShop
//
//  Created by Alexander Fomin on 01.09.2021.
//

import UIKit

class SignUpView: UIView {
    
    private(set) lazy var scrollView = UIScrollView()
    
    private(set) lazy var captionLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 50)
        label.textColor = .cinnabar
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var loginTextField: UITextField = {
        let textFild = UITextField()
        textFild.translatesAutoresizingMaskIntoConstraints = false
        textFild.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textFild.textColor = .label
        textFild.borderStyle = .none
        textFild.autocorrectionType = .no
        textFild.clearButtonMode = .whileEditing
        textFild.placeholder = "имя пользователя"
        textFild.tintColor = UIColor.uaRed
        return textFild
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        let textFild = UITextField()
        textFild.translatesAutoresizingMaskIntoConstraints = false
        textFild.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textFild.textColor = .label
        textFild.borderStyle = .none
        textFild.autocorrectionType = .no
        textFild.clearButtonMode = .whileEditing
        textFild.placeholder = "пароль"
        textFild.tintColor = UIColor.uaRed
        return textFild
    }()
    
    private(set) lazy var emailTextField: UITextField = {
        let textFild = UITextField()
        textFild.translatesAutoresizingMaskIntoConstraints = false
        textFild.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textFild.textColor = .label
        textFild.borderStyle = .none
        textFild.autocorrectionType = .no
        textFild.clearButtonMode = .whileEditing
        textFild.placeholder = "e-mail"
        textFild.tintColor = UIColor.uaRed
        return textFild
    }()
    
    private(set) lazy var creditCardTextField: UITextField = {
        let textFild = UITextField()
        textFild.translatesAutoresizingMaskIntoConstraints = false
        textFild.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textFild.textColor = .label
        textFild.borderStyle = .none
        textFild.autocorrectionType = .no
        textFild.clearButtonMode = .whileEditing
        textFild.placeholder = "номер карты"
        textFild.tintColor = UIColor.uaRed
        return textFild
    }()
    
    private(set) lazy var genderSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Мужчина", "Женщина"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private(set) lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray4
        label.text = "о себе"
        return label
    }()
    
    private(set) lazy var bioTextView: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .label
        textView.textAlignment = .justified
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.blueSappire.cgColor
        textView.font = .systemFont(ofSize: 14)
        textView.autocorrectionType = .no
        textView.isScrollEnabled = false
        return textView
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.backgroundColor = .systemBackground
        button.tintColor = UIColor.cinnabar
        return button
    }()
    
    private(set) lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Выйти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.backgroundColor = .systemBackground
        button.tintColor = UIColor.cinnabar
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populate(user: User) {
        loginTextField.text = user.login
    }
    
    private func configureUI() {
        self.backgroundColor = .systemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.adjustsFontForContentSizeCategory = false
        
        guard let customFont = UIFont(name: "Parangon410C", size: 50) else {
            fatalError("Failed to load the \"Parangon210C\" font"
            )
        }
        captionLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        
        self.addSubview(scrollView)
        self.addSubview(captionLabel)
        scrollView.addSubview(loginTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(genderSegmentedControl)
        scrollView.addSubview(creditCardTextField)
        scrollView.addSubview(bioLabel)
        scrollView.addSubview(bioTextView)
        scrollView.addSubview(signUpButton)
        scrollView.addSubview(logoutButton)
        
        configureConstrains()
    }
    
    private func configureConstrains() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: captionLabel.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            captionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            captionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            captionLabel.heightAnchor.constraint(equalToConstant: 60),
            
            loginTextField.topAnchor.constraint(equalTo: scrollView.topAnchor),
            loginTextField.heightAnchor.constraint(equalToConstant: 44),
            loginTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            loginTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            genderSegmentedControl.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            genderSegmentedControl.heightAnchor.constraint(equalToConstant: 44),
            genderSegmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),

            creditCardTextField.topAnchor.constraint(equalTo: genderSegmentedControl.bottomAnchor, constant: 16),
            creditCardTextField.heightAnchor.constraint(equalToConstant: 44),
            creditCardTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            creditCardTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            bioLabel.topAnchor.constraint(equalTo: creditCardTextField.bottomAnchor, constant: 16),
            bioLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),

            bioTextView.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 16),
            bioTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            bioTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            bioTextView.heightAnchor.constraint(equalToConstant: 88),
            bioTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            
            signUpButton.topAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: 16),
            signUpButton.widthAnchor.constraint(equalToConstant: 100),
            signUpButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            logoutButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.layoutIfNeeded()
    }
}
