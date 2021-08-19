//
//  SceneDelegate.swift
//  GBShop
//
//  Created by Alexander Fomin on 19.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let requestFactory = RequestFactory()

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        let auth = requestFactory.makeAuthRequestFatory()
        let goods = requestFactory.makeGoodsRequestFatory()

        // MARK: - AUTH
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.registerUser(id: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru",
                          gender: UserGender.male, creditCard: "9872389-2424-234224-234",
                          bio: "This is good! I think I will switch to another language") { response in
            switch response {
            case .success(let answer):
                print(answer)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.logout(id: 123) { response in
            switch response {
            case .success(let answer):
                print(answer)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.changeUserData(id: 123, userName: "Somebody", password: "mypassword", email: "some@some.ru",
                            gender: UserGender.male, creditCard: "9872389-2424-234224-234",
                            bio: "This is good! I think I will switch to another language") { response in
            switch response {
            case .success(let answer):
                print(answer)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        // MARK: - GOODS
        goods.getProductById(id: 123) { response in
            switch response {
            case .success(let answer):
                print(answer)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        goods.getCatalogData(page: 1, category: 1) { response in
            switch response {
            case .success(let answer):
                print(answer)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
