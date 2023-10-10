//
//  Checker.swift
//  Navigation
//
//  Created by Kr Qqq on 16.08.2023.
//

import Foundation

final class Checker {
    
    static let shared = Checker()
    
    private let login: String
    private let password: String
    
    private init() {
        login = "Ivan"
        password = "1gRt"
    }
    
    public func check(login: String, password: String) -> Bool  {
        login == self.login && password == self.password
    }
}

extension Checker: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) throws
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) throws {
        
        #if DEBUG
        //true
        #else
        if login.isEmpty {
            throw LoginError.emptyLogin
        } else if login.count < 3 {
            throw LoginError.shortLogin
        } else if password.isEmpty {
            throw LoginError.emptyPassword
        } else if !Checker.shared.check(login: login, password: password) {
            throw LoginError.unauthorized
        }
        #endif

    }
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
