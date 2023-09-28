//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import Foundation

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
    
    func findPassword(login: String) -> String? {
        guard !login.isEmpty else {
            coordinator.showFailLogin()
            return nil
            
        }
        let bruteForceModel = BruteForceModel()
        bruteForceModel.loginDelegate = loginDelegate
        return bruteForceModel.bruteForce(login: login)
    }
}
