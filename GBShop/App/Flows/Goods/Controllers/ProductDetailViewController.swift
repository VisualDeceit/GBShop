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
    
    let productId: Int
    let requestFactory = RequestFactory()
    var goods: GoodsRequestFactory!
    var product: ProductResult?
    
    init(productId: Int) {
        self.productId = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        getProduct()
    }
    
    override func loadView() {
        self.view = ProductDetailView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let totalScrollViewHeight = productDetailView.frame.height + (self.tabBarController?.tabBar.frame.height ?? 49.0) + productDetailView.addToCartButton.frame.height + 32.0
        productDetailView.scrollView.contentSize = CGSize(width: self.view.bounds.width, height: totalScrollViewHeight)
    }
    
    private func fillView() {
        if let product = product {
            productDetailView.productName.text = product.name
            productDetailView.productPrice.text = "\(product.price) ₽"
            productDetailView.descriptionText.text = product.description
            productDetailView.addToCartButton.setTitle("В козину за \(product.price) ₽", for: .normal)
        }
    }
    
    private func getProduct() {
        goods = requestFactory.makeGoodsRequestFatory()
        goods.getProductById(id: self.productId) {[weak self] result in
            switch result {
            case .success(let product):
                self?.product = product
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.fillView()
        }
    }
}
