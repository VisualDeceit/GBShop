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
        
        let accountViewController: UIViewController
        
        if Session.shared.userId == nil {
            accountViewController = LoginViewController()
        } else {
            accountViewController = SignUpViewController(type: .changeUserData("Личные данные", "Изменить"))
        }
        
        accountViewController.tabBarItem = UITabBarItem(title: "Кабинет", image: UIImage(systemName: "person"), tag: 0)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([accountViewController], animated: false)
        tabBarController.tabBar.tintColor = UIColor.cinnabar
        
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}
