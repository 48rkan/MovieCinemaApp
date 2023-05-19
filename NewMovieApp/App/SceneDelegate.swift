//
//  SceneDelegate.swift
//  NewMovieApp
//
//  Created by Erkan Emir on 08.04.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = TabBarController()
        GenreClass.shared.fetchAllGenre()
        window?.makeKeyAndVisible()
        
        print("willConnectTo called")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("sceneDidDisconnect called")
    }

    func sceneDidBecomeActive(_ scene: UIScene)  {
        print("sceneDidBecomeActive called")
    }

    func sceneWillResignActive(_ scene: UIScene)   {
        print("sceneWillResignActive called")
    }

    func sceneWillEnterForeground(_ scene: UIScene)  {
        print("sceneWillEnterForeground called")
    }

    func sceneDidEnterBackground(_ scene: UIScene)     {
        print("sceneDidEnterBackground called")
    }

}

