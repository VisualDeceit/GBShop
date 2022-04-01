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
        let requestFactory = RequestFactory()
        
        let accountViewController = LoginViewController(with: requestFactory)
        accountViewController.tabBarItem = UITabBarItem(title: "Кабинет", image: UIImage(systemName: "person"), tag: 0)
        accountViewController.tabBarItem.accessibilityIdentifier = "tbOffice"
        
        let catalogViewController = CatalogViewController(with: requestFactory)
        let catalogNavController = UINavigationController(rootViewController: catalogViewController)
        catalogNavController.tabBarItem = UITabBarItem(title: "Каталог", image: UIImage(systemName: "list.dash"), tag: 0)
        catalogNavController.tabBarItem.accessibilityIdentifier = "tbCatalog"
        
        let cartViewController = CartViewController(with: requestFactory)
        cartViewController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "cart"), tag: 0)
        cartViewController.tabBarItem.accessibilityIdentifier = "tbCart"
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([catalogNavController, cartViewController, accountViewController], animated: false)
        tabBarController.tabBar.tintColor = UIColor.cinnabar
        tabBarController.selectedIndex = 2
     
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }
}
