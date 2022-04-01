//
//  CartCell.swift
//  GBShop
//
//  Created by Alexander Fomin on 23.09.2021.
//

import UIKit

class CartCell: UITableViewCell {

    static let identifier = "kCartCell"
    
    private(set) lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.secondarySystemFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "product")
        return imageView
    }()
    
    private(set) lazy var productName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .label
        return label
    }()
    
    private(set) lazy var productPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private(set) lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.backgroundColor = .systemGray5
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productImageView)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(quantityLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productName.text = ""
        productPrice.text = ""
    }
    
    func configure(with cartItem: CartItem) {
        productName.text = cartItem.product.name
        productPrice.text = "\(cartItem.product.price) ₽"
        quantityLabel.text = "\(cartItem.quantity) шт."
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            productName.topAnchor.constraint(equalTo: productImageView.topAnchor),
            productName.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productName.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -8),
           
            quantityLabel.topAnchor.constraint(equalTo: productImageView.topAnchor),
            quantityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            quantityLabel.widthAnchor.constraint(equalToConstant: 60),
            
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 8),
            productPrice.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            productPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            productPrice.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
