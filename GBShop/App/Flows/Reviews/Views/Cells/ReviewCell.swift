//
//  ReviewCell.swift
//  GBShop
//
//  Created by Alexander Fomin on 19.09.2021.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    static let identifier = "kReviewCell"

    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        df.locale = Locale(identifier: "ru_Ru")
        return df
    }()
    
    private(set) lazy var reviewCaption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .label
        return label
    }()
    
    private(set) lazy var reviewDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray3
        return label
    }()
 
    private(set) lazy var reviewRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private(set) lazy var reviewComment: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(reviewCaption)
        contentView.addSubview(reviewDate)
        contentView.addSubview(reviewRating)
        contentView.addSubview(reviewComment)
        
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(review: Review) {
        reviewCaption.text = review.caption
        reviewDate.text = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(review.date)))
        reviewRating.text = "\(review.rating) из 5"
        reviewComment.text = review.comment
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            reviewRating.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            reviewRating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            reviewDate.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            reviewDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            reviewCaption.topAnchor.constraint(equalTo: reviewRating.bottomAnchor, constant: 8),
            reviewCaption.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            reviewComment.topAnchor.constraint(equalTo: reviewCaption.bottomAnchor, constant: 8),
            reviewComment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            reviewComment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            reviewComment.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
