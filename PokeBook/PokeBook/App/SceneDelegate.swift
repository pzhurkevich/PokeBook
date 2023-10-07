//
//  SceneDelegate.swift
//  PokeBook
//
//  Created by Pavel on 21.09.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController = PokemonListRouter.createPokemonListModule()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
        self.window = window
    }
}

