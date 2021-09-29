//
//  ReviewsViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 19.09.2021.
//

import UIKit
import FirebaseAnalytics

class ReviewsViewController: UIViewController {
    let requestFactory: RequestFactory
    let reviewsFactory: ReviewsRequestFactory
    var productID: Int
    var reviews = [Review]()
    
    private lazy var reviewsView = ReviewsView()
    private var newReviewView: NewReviewView!
    
    init(with productID: Int, requestFactory: RequestFactory) {
        self.productID = productID
        self.requestFactory = requestFactory
        reviewsFactory = self.requestFactory.makeReviewsRequestFatory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = reviewsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsView.reviewsTableView.dataSource = self
        let showViewToAddReviewButton = UIBarButtonItem(image: UIImage(systemName: "plus.bubble"), style: .plain, target: self, action: #selector(onShowViewToAddReviewButtonPressed))
        navigationItem.rightBarButtonItem = showViewToAddReviewButton
        navigationItem.rightBarButtonItem?.tintColor = .blueSappire
        getReviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if newReviewView != nil {
            newReviewView.captionTextField.setUnderLine()
        }
    }
    
    // MARK: - Private
    @objc func onShowViewToAddReviewButtonPressed() {
        newReviewView = NewReviewView()
        newReviewView.postReviewButton.addTarget(self, action: #selector(onPostReviewButtonPressed), for: .touchUpInside)
        navigationItem.rightBarButtonItem = nil
        self.view = newReviewView
    }
    
    @objc func onPostReviewButtonPressed() {
        let review = Review(caption: newReviewView.captionTextField.text ?? "Нет заголовка",
                            date: Int(Date().timeIntervalSince1970),
                            rating: newReviewView.ratingSegmentedControl.selectedSegmentIndex,
                            comment: newReviewView.commentTextView.text)
        reviewsFactory.addReview(userId: 1, productId: productID, review: review) { [weak self] result in
            switch result {
            case .success(let resultReviews):
                if resultReviews.result == 1 {
                    Analytics.logEvent("new_review", parameters: [
                        "caption": review.caption as NSObject,
                        "date": review.date as NSInteger,
                        "rating": review.rating as NSInteger,
                        "comment": review.comment as NSString
                    ])
                    self?.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getReviews() {
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

// MARK: - TableViewDataSource
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
