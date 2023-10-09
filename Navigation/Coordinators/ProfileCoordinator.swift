//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import UIKit

protocol ProfileCoordinatorProtocol {
    func showFailLogin(text: String)
    func showProfile(user: User)
    func showForgotLogin(action: @escaping (UIAlertAction) -> Void)
}

final class ProfileCoordinator: ProfileCoordinatorProtocol {

    var navigationController: UINavigationController?

    func showFailLogin(text: String) {
        let alert = UIAlertController(title: "Fail", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showProfile(user: User) {
        let profileViewController = ProfileViewController(user: user)
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func showForgotLogin(action: @escaping (UIAlertAction) -> Void) {
        if navigationController?.presentedViewController != nil { return }
        
        let alert = UIAlertController(title: "Did you forget your password?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Remind me!", style: .default, handler: action))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
