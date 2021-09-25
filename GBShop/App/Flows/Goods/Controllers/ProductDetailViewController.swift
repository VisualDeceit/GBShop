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
    var cartRequestFactory: CartRequestFactory!
    let requestFactory = RequestFactory()
    
    private var productDetailView: ProductDetailView {
        // swiftlint:disable force_cast
        self.view as! ProductDetailView
        // swiftlint:enable force_cast
    }
    
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
        cartRequestFactory = requestFactory.makeCartRequestFatory()
        productDetailView.showReviewsButton.addTarget(self, action: #selector(showReviews), for: .touchUpInside)
        productDetailView.addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
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
    
    @objc func addToCart() {
        cartRequestFactory.addToCartProduct(id: (self.productID ?? 0), quantity: 1) { result in
            switch result {
            case .success(let data):
                if data.result == 0 {
                    print("Ошибка при добавлении:" + String(describing: data.error))
                } else {
                    print("Товар успешно добавлен: " + String(describing: data.message))
                }
            case .failure(let error):
                print("Ошибка при добавлении: \(error)")
            }
        }
        
        if let cartItemIndex = Purchase.cart.items.firstIndex(where: { $0.product.id == self.productID }) {
            Purchase.cart.items[cartItemIndex].quantity += 1
        } else {
            let cartItem = CartItem(quantity: 1,
                                    product: Product(id: self.productID ?? 0,
                                                     name: product?.name ?? "",
                                                     price: product?.price ?? 0))
            Purchase.cart.items.append(cartItem)
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
