//
//  ReviewsViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 19.09.2021.
//

import UIKit

class ReviewsViewController: UIViewController {
    var requestFactory = RequestFactory()
    var reviewsFactory: ReviewsRequestFactory!
    var productID: Int
    var reviews = [Review]()
    
    private var reviewsView = ReviewsView()
    
    init(with productID: Int) {
        self.productID = productID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = reviewsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsView.reviewsTableView.dataSource = self
        
        getReviews()
    }
    
    private func getReviews() {
        reviewsFactory = requestFactory.makeReviewsRequestFatory()
        reviewsFactory.getReviewsForProduct(id: productID) { [weak self] result in
            switch result {
            case .success(let resultReviews):
                self?.reviews.removeAll()
                self?.reviews.append(contentsOf: resultReviews.reviews)
                self?.reviewsView.reviewsTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ReviewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier) as? ReviewCell else {
            return UITableViewCell()
        }
        
        let review = reviews[indexPath.row]
        cell.configure(review: review)
        return cell
    }
}
