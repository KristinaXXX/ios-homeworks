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
        if login.isEmpty {
            throw LoginError.emptyLogin
        } else if !isValidEmail(login) {
            throw LoginError.invalidEmail
        } else if password.count < 6 {
            throw LoginError.shortPassword
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
