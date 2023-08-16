//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Kr Qqq on 06.08.2023.
//

import Foundation

class CurrentUserService: UserService {
    
    let user: User = User()
    
    func takeUser(login: String) -> User? {
        login == user.login ? user : nil
    }
}
