//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 07.09.2021.
//

import UIKit

class CatalogViewController: UIViewController {
    
    private var catalogView: CatalogView {
        // swiftlint:disable force_cast
        self.view as! CatalogView
        // swiftlint:enable force_cast
    }
    
    let requestFactory = RequestFactory()
    var goods: GoodsRequestFactory!
    var products = [Product]()
    
    override func loadView() {
        self.view = CatalogView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        navigationItem.title = "Каталог"
 
        catalogView.collectionView.dataSource = self
        catalogView.collectionView.delegate = self
      
        getCatalog()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.cinnabar,
            .font: UIFontMetrics.default.scaledFont(for: UIFont.captionParangon25)
        ]
    }
    
    private func getCatalog() {
        goods = requestFactory.makeGoodsRequestFatory()
        goods.getCatalogData(page: 1, category: 1) { [weak self] result in
            switch result {
            case .success(let catalog):
                self?.products = catalog
                self?.catalogView.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func showProductDetail(with id: Int) {
        goods = requestFactory.makeGoodsRequestFatory()
        goods.getProductById(id: id) {[weak self] result in
            switch result {
            case .success(let product):
                let productDetailVC = ProductDetailViewController(with: product)
                productDetailVC.productID = id
                self?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                self?.navigationItem.backBarButtonItem?.tintColor = UIColor.blueSappire
                self?.navigationController?.pushViewController(productDetailVC, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - CollectionViewDataSource
extension CatalogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCell.identifier, for: indexPath) as? CatalogCell {
            dequeuedCell.productName.text  = products[indexPath.row].name
            dequeuedCell.productPrice.text = "\(products[indexPath.row].price) ₽"
            return dequeuedCell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension CatalogViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showProductDetail(with: products[indexPath.row].id)
    }
}
