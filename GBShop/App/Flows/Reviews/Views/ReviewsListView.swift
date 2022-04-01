//
//  ReviewsView.swift
//  GBShop
//
//  Created by Alexander Fomin on 19.09.2021.
//

import UIKit

class ReviewsListView: UIView {

    var reviewsTableView: UITableView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        reviewsTableView = UITableView()
        reviewsTableView.translatesAutoresizingMaskIntoConstraints = false
        reviewsTableView.backgroundColor = .systemBackground
        reviewsTableView.rowHeight = UITableView.automaticDimension
        reviewsTableView.estimatedRowHeight = 50
        reviewsTableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
        self.addSubview(reviewsTableView)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            reviewsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            reviewsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            reviewsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            reviewsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
