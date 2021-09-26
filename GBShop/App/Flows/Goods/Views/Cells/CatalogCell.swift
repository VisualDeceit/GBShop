//
//  CatalogCell.swift
//  GBShop
//
//  Created by Alexander Fomin on 12.09.2021.
//

import UIKit

class CatalogCell: UICollectionViewCell {
    
    static let identifier = "kCatalogCell"
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(productImageView)
        self.addSubview(productName)
        self.addSubview(productPrice)
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
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageView.heightAnchor.constraint(equalTo: self.widthAnchor),
            
            productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            productName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            productPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            productPrice.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8)
        ])
    }
}
