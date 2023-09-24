//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import UIKit

protocol ProfileCoordinatorProtocol {
    func showFailLogin()
    func showProfile(user: User)
}

final class ProfileCoordinator: ProfileCoordinatorProtocol {

    var navigationController: UINavigationController?

    func showFailLogin() {
        let alert = UIAlertController(title: "Fail", message: "Login isn't correct", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showProfile(user: User) {
        let profileViewController = ProfileViewController(user: user)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
}