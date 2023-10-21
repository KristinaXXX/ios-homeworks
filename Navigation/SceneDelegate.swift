//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Kr Qqq on 30.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        
        let mainCoordinator = MainCoordinator()
        
        window.rootViewController = mainCoordinator.startApplication()
        window.makeKeyAndVisible()
        
        //NetworkService.request(url: AppConfiguration.people.url!)
        
        self.window = window
    }
}

