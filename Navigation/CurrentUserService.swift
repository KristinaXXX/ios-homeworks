//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Kr Qqq on 06.08.2023.
//

import Foundation

class CurrentUserService: UserService {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func takeUser(login: String) -> User? {
        if login == user.login {
            return user
        }
        return nil
    }
}
