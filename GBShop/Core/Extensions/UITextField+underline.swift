//
//  UITextField+underline.swift
//  GBShop
//
//  Created by Alexander Fomin on 04.09.2021.
//

import UIKit

extension UITextField {
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor.blueSappire.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
