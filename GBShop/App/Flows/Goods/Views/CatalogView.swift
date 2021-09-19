//
//  CatalogView.swift
//  GBShop
//
//  Created by Alexander Fomin on 08.09.2021.
//

import UIKit

class CatalogView: UIView {
    private(set) lazy var collectionView: UICollectionView = {
        let spaceBetweenCell: CGFloat = 8.0
        let screenWidth = UIScreen.main.bounds.size.width - spaceBetweenCell * 2.0
        let itemSize = CGSize(width: (screenWidth - spaceBetweenCell) / 2.0, height: (screenWidth - spaceBetweenCell) / 2.0 + 88)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spaceBetweenCell, left: spaceBetweenCell, bottom: spaceBetweenCell, right: spaceBetweenCell)
        layout.itemSize = itemSize
        layout.minimumLineSpacing = spaceBetweenCell
        layout.minimumInteritemSpacing = spaceBetweenCell
          
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        
        cv.register(CatalogCell.self, forCellWithReuseIdentifier: CatalogCell.identifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
