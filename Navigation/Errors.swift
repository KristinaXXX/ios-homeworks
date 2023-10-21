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
    case shortLogin
    case unauthorized
}

enum PhotosError: Error {
    case badRequest
    case notFound
    case forbidden
}

enum NetworkError: Error {
    case error(String)
    case parseError
    case emptyData
    
    //var description: String
}
