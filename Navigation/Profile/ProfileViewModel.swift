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
        
        do {
            try loginDelegate?.check(login: userInfo.login, password: userInfo.password)
            let user = userService.takeUser(login: userInfo.login)
            coordinator.showProfile(user: user)
        } catch LoginError.emptyLogin {
            coordinator.showFailLogin(text: "Login can't be empty.")
        } catch LoginError.emptyPassword {
            coordinator.showFailLogin(text: "Password can't be empty.")
        } catch LoginError.shortLogin {
            coordinator.showFailLogin(text: "login must be longer than 3 characters")
        } catch LoginError.unauthorized {
            coordinator.showFailLogin(text: "The login is not a valid.")
        } catch {
            coordinator.showFailLogin(text: "Error")
        }
       
    }
    
    func checkLogin(login: String) -> Bool {
        guard !login.isEmpty else {
            coordinator.showFailLogin(text: "Login can't be empty.")
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
