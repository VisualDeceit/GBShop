//
//  ReviewsViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 19.09.2021.
//

import UIKit

class ReviewsViewController: UIViewController {
    let requestFactory: RequestFactory
    let reviewsFactory: ReviewsRequestFactory
    var productID: Int
    var reviews = [Review]()
    
    private lazy var reviewsListView = ReviewsListView()
    private var addReviewView: AddReviewView!
    
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
        self.view = reviewsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsListView.reviewsTableView.dataSource = self
        let showViewToAddReviewButton = UIBarButtonItem(image: UIImage(systemName: "plus.bubble"), style: .plain, target: self, action: #selector(onShowViewToAddReviewButtonPressed))
        navigationItem.rightBarButtonItem = showViewToAddReviewButton
        navigationItem.rightBarButtonItem?.tintColor = .blueSappire
        getReviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if addReviewView != nil {
            addReviewView.captionTextField.setUnderLine()
        }
    }
    
    // MARK: - Private
    @objc func onShowViewToAddReviewButtonPressed() {
        addReviewView = AddReviewView()
        addReviewView.postReviewButton.addTarget(self, action: #selector(onPostReviewButtonPressed), for: .touchUpInside)
        UIView.transition(from: self.view,
                          to: addReviewView,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft])
        navigationItem.rightBarButtonItem = nil
        self.view = addReviewView
    }

    @objc func onPostReviewButtonPressed() {
        let review = Review(caption: addReviewView.captionTextField.text ?? "Нет заголовка",
                            date: Int(Date().timeIntervalSince1970),
                            rating: addReviewView.ratingSegmentedControl.selectedSegmentIndex,
                            comment: addReviewView.commentTextView.text)
        reviewsFactory.addReview(userId: 1, productId: productID, review: review) { [weak self] result in
            switch result {
            case .success(let content):
                guard content.result == 1 else {
                    return }
                AnalyticsFacade.shared.addReview(item: review)
                self?.navigationController?.popViewController(animated: true)
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
                self?.reviewsListView.reviewsTableView.reloadData()
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
