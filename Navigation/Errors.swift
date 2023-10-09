//
//  Errors.swift
//  Navigation
//
//  Created by Kr Qqq on 08.10.2023.
//

import Foundation

enum LoginError: Error {
    case emptyLogin
    case emptyPassword
    //case forbiddenSymbols
    case shortLogin
    case unauthorized
}
