//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let feedVC = FactoryTab(flow: .feed)
    private let profileVC = FactoryTab(flow: .profile)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [
            feedVC.navigationController,
            profileVC.navigationController
        ]
        
        selectedIndex = 1
        tabBar.backgroundColor = .systemGray6
        tabBar.isHidden = true
    }
}
