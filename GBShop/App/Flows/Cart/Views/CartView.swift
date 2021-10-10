//
//  CartView.swift
//  GBShop
//
//  Created by Alexander Fomin on 21.09.2021.
//

import UIKit

class CartView: UIView {
    var cartTableView: UITableView!
    
    private(set) lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Оплатить заказ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .cinnabar
        button.tintColor = .white
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 5.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cartTableView = UITableView()
        cartTableView.translatesAutoresizingMaskIntoConstraints = false
        cartTableView.backgroundColor = .systemBackground
        cartTableView.separatorStyle = .none
        cartTableView.rowHeight = UITableView.automaticDimension
        cartTableView.sectionHeaderHeight = UITableView.automaticDimension
        cartTableView.estimatedSectionHeaderHeight = 50
        cartTableView.estimatedRowHeight = 50
        cartTableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
        cartTableView.register(CartHeaderView.self, forHeaderFooterViewReuseIdentifier: CartHeaderView.identifier)

        self.addSubview(cartTableView)
        setupConstrains()
        
        addSubview(payButton)
        NSLayoutConstraint.activate([
            payButton.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor, constant: -8),
            payButton.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            cartTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cartTableView.topAnchor.constraint(equalTo: self.topAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
