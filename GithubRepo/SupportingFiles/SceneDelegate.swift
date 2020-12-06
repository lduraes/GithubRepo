//
//  SceneDelegate.swift
//  GithubRepo
//
//  Created by lduraes on 06/12/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
   var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if (scene as? UIWindowScene) != nil {
            let viewController = ListRepositoryViewController()
            
            if let windowScene = scene as? UIWindowScene {
                window = UIWindow(windowScene: windowScene)
                window?.rootViewController = UINavigationController(rootViewController: viewController)
                window?.makeKeyAndVisible()
            }
        }
    }
}
