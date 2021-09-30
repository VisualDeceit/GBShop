//
//  UIViewPreview.swift
//  GBShop
//
//  Created by Alexander Fomin on 16.09.2021.
//

import Foundation
import SwiftUI

/// Используется для отображения в превью Xcode
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    private let view: View
    
    init(_ view: View) {
        self.view = view
    }
    
    func makeUIView(context: Context) -> View {
        return view
    }
    
    func updateUIView(_ uiView: View, context: Context) {}
}
