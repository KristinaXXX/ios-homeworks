//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import Foundation
import UIKit

final class ProfileViewModel {

    private let coordinator: ProfileCoordinatorProtocol
    var loginDelegate: LoginViewControllerDelegate?
    let userService = TestUserService()
    
    
    init(coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func checkLoginToProfile(userInfo: UserInfo) {
        guard loginDelegate?.check(login: userInfo.login, password: userInfo.password) == true else {
            coordinator.showFailLogin()
            return
        }

        let user = userService.takeUser(login: userInfo.login)
        coordinator.showProfile(user: user)
    }
    
    func checkLogin(login: String) -> Bool {
        guard !login.isEmpty else {
            coordinator.showFailLogin()
            return false
        }
        return true
    }
    
    func findPassword(login: String) -> String? {
        let bruteForceModel = BruteForceModel()
        bruteForceModel.loginDelegate = loginDelegate
        return bruteForceModel.bruteForce(login: login)
    }
    
    func rememberPassword(action: @escaping (UIAlertAction) -> Void) {
        coordinator.showForgotLogin(action: action)
    }
}
