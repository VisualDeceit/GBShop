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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.cinnabar,
            .font: UIFontMetrics.default.scaledFont(for: UIFont.captionParangon50)
        ]
        
        catalogView.tableView.dataSource = self
        
        goods = requestFactory.makeGoodsRequestFatory()
        getCatalog()
    }
    
    private func getCatalog() {
        goods.getCatalogData(page: 1, category: 1) { [weak self] result in
            switch result {
            case .success(let catalog):
                self?.products = catalog
                self?.catalogView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CatalogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if dequeuedCell == nil {
            dequeuedCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        }
        
        guard let cell = dequeuedCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = products[indexPath.row].name
        cell.detailTextLabel?.text = "\(products[indexPath.row].price) руб."
        return cell
    }
}
