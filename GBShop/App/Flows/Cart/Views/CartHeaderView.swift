//
//  CartHeaderView.swift
//  GBShop
//
//  Created by Alexander Fomin on 22.09.2021.
//

import UIKit

class CartHeaderView: UITableViewHeaderFooterView {
    static let identifier = "kCartHeader"
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = "Итого с учетом скидок" 
        label.textColor = .label
        return label
    }()
    
    private(set) lazy var summLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        tintColor = .systemBackground
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
            contentView.addSubview(captionLabel)
            contentView.addSubview(summLabel)

            NSLayoutConstraint.activate([
                captionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
                summLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 16),
                summLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                summLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
    }
}
