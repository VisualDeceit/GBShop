//
//  AppLaunchManager.swift
//  GBShop
//
//  Created by Alexander Fomin on 30.08.2021.
//

import UIKit

/// Менеджер запуска приложения
class AppLaunchManager {
    private var windowScene: UIWindowScene
    var window: UIWindow?
    
    init?(with scene: UIScene?) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return nil
        }
        self.windowScene = windowScene
    }
    
    func start() {
        let window = UIWindow(windowScene: windowScene)
        let loginViewController = LoginViewController()
        window.rootViewController = loginViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
