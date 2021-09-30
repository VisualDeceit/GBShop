//
//  CartViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 21.09.2021.
//

import UIKit
import FirebaseAnalytics

class CartViewController: UIViewController {
    
    let cartRequestFactory: CartRequestFactory
    let requestFactory: RequestFactory
    
    private lazy var cartView = CartView()
    
    init(with requestFactory: RequestFactory) {
        self.requestFactory = requestFactory
        self.cartRequestFactory = self.requestFactory.makeCartRequestFatory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = cartView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartView.payButton.addTarget(self, action: #selector(onPayButtonPressed), for: .touchUpInside)
        cartView.cartTableView.dataSource = self
        cartView.cartTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartView.cartTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cartView.payButton.isHidden = true
    }
  
    // MARK: - Private
    @objc func onPayButtonPressed() {
        cartRequestFactory.payCart {[weak self] result in
            switch result {
            case .success(let content):
                guard content.result == 1 else {
                    let alert = UIAlertController(title: "Ошибка", message: content.error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    self?.present(alert, animated: true)
                    return
                }
                AnalyticsFacade.purchase()
                Purchase.cart.items.removeAll()
                self?.cartView.cartTableView.reloadData()
                
            case .failure(let error):
                print("Ошибка при оплате: \(error)")
            }
        }
    }
}
// MARK: - TableViewDataSource, TableViewDelegate
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Purchase.cart.items.isEmpty {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
            messageLabel.text = "Корзина пуста"
            messageLabel.textColor = .systemGray
            messageLabel.textAlignment = .center
            messageLabel.font = .systemFont(ofSize: 18, weight: .semibold)
            messageLabel.sizeToFit()
            
            cartView.cartTableView.backgroundView = messageLabel
            cartView.payButton.isHidden = true
        } else {
            cartView.cartTableView.backgroundView = nil
            cartView.payButton.isHidden = false
        }
        return Purchase.cart.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier) as? CartCell
        else { return UITableViewCell() }
        
        cell.configure(with: Purchase.cart.items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CartHeaderView.identifier) as? CartHeaderView,
              !Purchase.cart.items.isEmpty else { return nil }
        view.summLabel.text = "\(Purchase.total) ₽"
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        Purchase.cart.items.isEmpty ? 0 : 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let productID = Purchase.cart.items[indexPath.row].product.id
            // Запрос на удаление
            cartRequestFactory.removeFromCartProduct(id: productID) {result in
                switch result {
                case .success(let content):
                    guard content.result == 1 else {
                        print("Ошибка при удалении: " + String(describing: content.error))
                        return
                    }
                    // Аналитика
                    AnalyticsFacade.removeFromCart(item: Purchase.cart.items[indexPath.row])
                    //  Удаление из таблицы
                    Purchase.cart.items.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    if Purchase.cart.items.isEmpty {
                        tableView.tableHeaderView = nil
                    }
                case .failure(let error):
                    print("Ошибка при удалении: \(error)")
                }
            }
        }
    }
}
