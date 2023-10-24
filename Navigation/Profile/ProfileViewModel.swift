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
    
    private func checkLoginToProfile(userInfo: UserInfo) -> Bool {
        
        do {
            try loginDelegate?.check(login: userInfo.login, password: userInfo.password)
            return true
        } catch LoginError.emptyLogin {
            coordinator.showFailLogin(text: "Login can't be empty.")
        } catch LoginError.shortPassword {
            coordinator.showFailLogin(text: "Password must be longer than 6 characters")
        } catch LoginError.invalidEmail {
            coordinator.showFailLogin(text: "Email is invalid")
        } catch LoginError.unauthorized {
            coordinator.showFailLogin(text: "The login is not a valid.")
        } catch {
            coordinator.showFailLogin(text: "Error")
        }
        
        return false
       
    }
    
    func logIn(userInfo: UserInfo) {
        
        if checkLoginToProfile(userInfo: userInfo) {
            CheckerService.checkCredentials(email: userInfo.login, password: userInfo.password) { [weak self]
                result in
                switch result {
                case .success(let fireBaseUser):
                    let user = User(email: fireBaseUser.user.email!)
                    self?.coordinator.showProfile(user: user)
                case.failure(let error):
                    self?.coordinator.showFailLogin(text: error.localizedDescription)
                }
            }
        }
    }
    
    func signOut() {
        CheckerService.signOut()
    }
    
    func sighUp(userInfo: UserInfo) {
        
        if checkLoginToProfile(userInfo: userInfo) {
            CheckerService.signUp(email: userInfo.login, password: userInfo.password) { [weak self]
                result in
                switch result {
                case .success(let fireBaseUser):
                    let user = User(email: fireBaseUser.user.email!)
                    self?.coordinator.showProfile(user: user)
                case.failure(let error):
                    self?.coordinator.showFailLogin(text: error.localizedDescription)
                }
            }
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
