//
//  LoginView.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.08.2021.
//

import UIKit

class LoginView: UIView {
    
    private(set) lazy var scrollView = UIScrollView()
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "GBShop")
        return imageView
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
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.backgroundColor = .systemBackground
        button.tintColor = UIColor.cinnabar
        return button
    }()
    
    private(set) lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.text = "Еще нет аккаунта? "
        return label
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = .systemBackground
        button.setTitle("Cоздайте новый.", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.tintColor = UIColor.cinnabar
       return button
    }()
    
    private lazy var signUpStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [signUpLabel, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private(set) lazy var loginBottomLine: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.blueSappire.cgColor
        return layer
    }()
    
    private(set) lazy var passwordBottomLine: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.blueSappire.cgColor
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .systemBackground
        
        configureScrollView()
        configureImageView()
        configureTextFields()
        configureLoginButton()
        configureStackView()
}
    
    private func configureScrollView() {
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureImageView() {
        scrollView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        ])
    }
    
    private func configureTextFields() {
        scrollView.addSubview(loginTextField)
        scrollView.addSubview(passwordTextField)
        
        loginTextField.layer.addSublayer(loginBottomLine)
        passwordTextField.layer.addSublayer(passwordBottomLine)
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            loginTextField.heightAnchor.constraint(equalToConstant: 44),
            loginTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20),
            loginTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.topAnchor, constant: 80),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        ])
    }
    
    private func configureLoginButton() {
        scrollView.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor)
        ])
    }
    
    private func configureStackView() {
        scrollView.addSubview(signUpStackView)
        
        NSLayoutConstraint.activate([
            signUpStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            signUpStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
            ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        loginBottomLine.frame = CGRect(x: 0.0, y: loginTextField.frame.height - 1, width: loginTextField.frame.width, height: 1.0)
        passwordBottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 1.0)
    }
}
