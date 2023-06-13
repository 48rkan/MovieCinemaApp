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
        FavouritedClass.shared.fetchFavourited()
        Token.shared.configure()
        window?.makeKeyAndVisible()
        
    }
}

