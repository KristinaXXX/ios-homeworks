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
                
        let feedViewController = FeedViewController()
        feedViewController.title = "Feed"
        feedViewController.view.backgroundColor = .white
        
        let logInViewController = LogInViewController()
        let factory = MyLoginFactory()
        logInViewController.loginDelegate = factory.makeLoginInspector()
        logInViewController.title = "Profile"
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .systemGray6
        
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "rectangle.stack.fill"), tag: 0)
        logInViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        
        let controllers = [feedViewController, logInViewController]
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        tabBarController.selectedIndex = 0
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
    }

}

