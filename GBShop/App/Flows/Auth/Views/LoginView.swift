//
//  LoginView.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.08.2021.
//

import UIKit

class LoginView: UIView {
    
    private(set) lazy var loginBottomLine: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.label.cgColor
        return layer
    }()
    
    private(set) lazy var passwordBottomLine: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.label.cgColor
        return layer
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
        return textFild
    }()
    
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.backgroundColor = .systemBackground
        return button
    }()
    
    private(set) lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.text = "Еще нет аккаунта? Тогда "
        return label
    }()
    
    private(set) lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemBackground
        button.setTitle("создайте новый.", for: .normal)
        button.contentHorizontalAlignment = .leading
       return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    func setupView() {
        self.backgroundColor = .systemBackground
        self.addSubview(loginTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
        self.addSubview(signUpLabel)
        self.addSubview(signUpButton)
        
        loginTextField.layer.addSublayer(loginBottomLine)
        passwordTextField.layer.addSublayer(passwordBottomLine)
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            loginTextField.heightAnchor.constraint(equalToConstant: 44),
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.topAnchor, constant: 80),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            signUpLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            signUpLabel.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),

            signUpButton.topAnchor.constraint(equalTo: signUpLabel.topAnchor),
            signUpButton.centerYAnchor.constraint(equalTo: signUpLabel.centerYAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: signUpLabel.trailingAnchor)
            ])
}

    override func layoutSubviews() {
        super.layoutSubviews()
        
        loginBottomLine.frame = CGRect(x: 0.0, y: loginTextField.frame.height - 1, width: loginTextField.frame.width, height: 1.0)
        passwordBottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 1.0)
    }
}
