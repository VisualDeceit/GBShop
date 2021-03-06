//
//  ProductDetailViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 14.09.2021.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var product: ProductResult?
    var productID: Int?
    let requestFactory: RequestFactory
    let cartRequestFactory: CartRequestFactory
    
    private var productDetailView = ProductDetailView()
    
    init(with product: ProductResult, requestFactory: RequestFactory) {
        self.product = product
        self.requestFactory = requestFactory
        self.cartRequestFactory = self.requestFactory.makeCartRequestFatory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = product {
            AnalyticsFacade.shared.getProductDetail(item: product)
        }
        self.view.backgroundColor = .systemBackground
        productDetailView.showReviewsButton.addTarget(self, action: #selector(onShowReviewsButtonPressed), for: .touchUpInside)
        productDetailView.addToCartButton.addTarget(self, action: #selector(onAddToCartButtonPressed), for: .touchUpInside)
        fillView()
    }
    
    override func loadView() {
        self.view = productDetailView
    }
    
    @objc func onShowReviewsButtonPressed() {
        if let productID = productID {
            let reviewsVC = ReviewsViewController(with: productID, requestFactory: requestFactory)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            navigationItem.backBarButtonItem?.tintColor = UIColor.blueSappire
            navigationController?.pushViewController(reviewsVC, animated: true)
        }
    }
    
    @objc func onAddToCartButtonPressed() {
        cartRequestFactory.addToCartProduct(id: (self.productID ?? 0), quantity: 1) {[weak self] result in
            switch result {
            case .success(let content):
                guard content.result == 1 else {
                    print("???????????? ?????? ????????????????????:" + String(describing: content.error))
                    return
                }
                if let product = self?.product {
                    AnalyticsFacade.shared.addToCart(item: product)
                }
            case .failure(let error):
                print("???????????? ?????? ????????????????????: \(error)")
            }
        }
    }
    
    private func fillView() {
        if let product = product {
            productDetailView.productName.text = product.name
            productDetailView.productPrice.text = "\(product.price) ???"
            productDetailView.descriptionText.text = product.description
            productDetailView.addToCartButton.setTitle("?? ???????????? ???? \(product.price) ???", for: .normal)
            productDetailView.layoutIfNeeded()
        }
    }
}
