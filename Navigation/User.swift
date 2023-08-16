//
//  User.swift
//  Navigation
//
//  Created by Kr Qqq on 06.08.2023.
//
import UIKit
import Foundation

class User {
    let login: String
    let fullName: String
    let status: String
    let avatar: UIImage
    
    init(login: String, fullName: String, status: String, avatar: UIImage) {
        self.login = login
        self.fullName = fullName
        self.status = status
        self.avatar = avatar
    }
    
    // default
    init() {
        self.login = "IvanPPP"
        self.fullName = "Petrov Ivan"
        self.status = "Reading..."
        self.avatar = UIImage(named: "avatarImage") ?? UIImage()
    }
}

protocol UserService {
    func takeUser(login: String) -> User?
}
