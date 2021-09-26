//
//  UIReviewButton.swift
//  GBShop
//
//  Created by Alexander Fomin on 18.09.2021.
//

import UIKit

class UIReviewButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.contentMode = .scaleAspectFit
        contentHorizontalAlignment = .leading
        imageEdgeInsets = UIEdgeInsets(top: 14, left: (bounds.width - 35), bottom: 14, right: 14)
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        
        path.move(to: CGPoint(x: 0, y: bounds.height))
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.blueSappire.cgColor
        shapeLayer.lineWidth = 1
        layer.addSublayer(shapeLayer)
    }
}
