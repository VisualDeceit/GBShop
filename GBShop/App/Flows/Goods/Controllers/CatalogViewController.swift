//
//  CatalogViewController.swift
//  GBShop
//
//  Created by Alexander Fomin on 07.09.2021.
//

import UIKit

class CatalogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        navigationItem.title = "Каталог"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.cinnabar,
            .font: UIFontMetrics.default.scaledFont(for: UIFont.captionParangon50)
        ] 
    }
}
