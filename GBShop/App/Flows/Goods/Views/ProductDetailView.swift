//
//  ProductDetailView.swift
//  GBShop
//
//  Created by Alexander Fomin on 14.09.2021.
//

import UIKit
import SwiftUI

class ProductDetailView: UIView {
    private(set) lazy var scrollView: UIScrollView = {
       let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .label
        return label
    }()
    
    private(set) lazy var productPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var descriptionCaption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "Описание"
        label.textColor = .label
        return label
    }()
    
    private(set) lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .label
        return label
    }()

    private(set) lazy var showReviewsButton: UIReviewButton = {
        let button = UIReviewButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отзывы", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.backgroundColor = .systemBackground
        button.tintColor = .label
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        return button
    }()
    
    private(set) lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("В козину за", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .cinnabar
        button.tintColor = .white
        button.accessibilityIdentifier = "addToCartButton"
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 5.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(productImageView)
        scrollView.addSubview(productName)
        scrollView.addSubview(productPrice)
        scrollView.addSubview(descriptionCaption)
        scrollView.addSubview(descriptionText)
        scrollView.addSubview(showReviewsButton)
        scrollView.addSubview(addToCartButton)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            productImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            productImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            productImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor),
            
            productName.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            productName.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16),
            
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 8),
            productPrice.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            
            descriptionCaption.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 16),
            descriptionCaption.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionCaption.bottomAnchor, constant: 16),
            descriptionText.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            descriptionText.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16),
            
            showReviewsButton.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            showReviewsButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            showReviewsButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16),
            showReviewsButton.heightAnchor.constraint(equalToConstant: 44),
            showReviewsButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -52),

            addToCartButton.bottomAnchor.constraint(equalTo: scrollView.readableContentGuide.bottomAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: scrollView.readableContentGuide.leadingAnchor, constant: 16),
            addToCartButton.trailingAnchor.constraint(equalTo: scrollView.readableContentGuide.trailingAnchor, constant: -16)
        ])
    }
}

struct ProductDetailView_Preview: PreviewProvider {
    static var previews: some View {
        let view = ProductDetailView()
        return UIViewPreview(view)
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
}
