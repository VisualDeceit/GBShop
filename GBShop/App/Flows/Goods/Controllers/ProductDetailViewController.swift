//
//  ProductDetailViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 14.09.2021.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    private var productDetailView: ProductDetailView {
        // swiftlint:disable force_cast
        self.view as! ProductDetailView
        // swiftlint:enable force_cast
    }
    
    var product: ProductResult?
    var productID: Int?
    
    init(with product: ProductResult) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        productDetailView.showReviewsButton.addTarget(self, action: #selector(showReviews), for: .touchUpInside)
        fillView()
    }
    
    override func loadView() {
        self.view = ProductDetailView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let totalScrollViewHeight = productDetailView.frame.height + (self.tabBarController?.tabBar.frame.height ?? 49.0) + productDetailView.addToCartButton.frame.height + 32.0
        productDetailView.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: totalScrollViewHeight)
    }
    
    @objc func showReviews() {
        if let productID = productID {
            let reviewsVC = ReviewsViewController(with: productID)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem?.tintColor = UIColor.blueSappire
            navigationController?.pushViewController(reviewsVC, animated: true)
        }
    }
    
    private func fillView() {
        if let product = product {
            productDetailView.productName.text = product.name
            productDetailView.productPrice.text = "\(product.price) ₽"
            productDetailView.descriptionText.text = product.description
            productDetailView.addToCartButton.setTitle("В козину за \(product.price) ₽", for: .normal)
        }
    }
}
