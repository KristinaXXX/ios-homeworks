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
    
    public func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }
}

extension Checker: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(login: login, password: password)
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
