//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import UIKit

protocol MainCoordinatorProtocol {
    func startApplication() -> UIViewController
}

final class MainCoordinator: MainCoordinatorProtocol {
    func startApplication() -> UIViewController {
        return MainTabBarController()
    }
}
