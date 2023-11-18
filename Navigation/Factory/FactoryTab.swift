//
//  FactoryTab.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import UIKit

final class FactoryTab {
    enum Flow {
        case feed
        case profile
        case shared
    }
    
    private let flow: Flow
    let navigationController = UINavigationController()
    
    init(flow: Flow) {
        self.flow = flow
        startModule()
    }
    
    private func startModule() {
        switch flow {
        case .feed:   
            let feedCoordinator = FeedCoordinator()
            let feedModel = FeedModel()
            let feedViewModel = FeedViewModel(feedModel: feedModel, coordinator: feedCoordinator)
            let feedViewController = FeedViewController(feedViewModel: feedViewModel)
            feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "rectangle.stack.fill"), tag: 0)
            feedCoordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Feed"
            navigationController.setViewControllers([feedViewController], animated: true)
       
        case .profile:
            let profileCoordinator = ProfileCoordinator()
            let factory = MyLoginFactory()
            let profileViewModel = ProfileViewModel(coordinator: profileCoordinator)
            profileViewModel.loginDelegate = factory.makeLoginInspector()
            let logInViewController = LogInViewController(profileViewModel: profileViewModel)
            logInViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)

            profileCoordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Profile"
            navigationController.setViewControllers([logInViewController], animated: true)
        
        case .shared:
            let coordinator = SharedCoordinator()
            //let model = SharedModel()
            let viewModel = SharedViewModel(coordinator: coordinator)
            let viewController = SharedViewController(viewModel: viewModel)
            viewController.tabBarItem = UITabBarItem(title: "Shared", image: UIImage(systemName: "square.and.arrow.down"), tag: 2)
            coordinator.navigationController = navigationController
            navigationController.tabBarItem.title = "Profile"
            navigationController.setViewControllers([viewController], animated: true)
        }
    }
}
