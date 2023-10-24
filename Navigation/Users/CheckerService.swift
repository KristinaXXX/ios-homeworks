//
//  CheckerService.swift
//  Navigation
//
//  Created by Kr Qqq on 22.10.2023.
//

import Foundation
import FirebaseAuth

struct FireBaseUser {
    let user: FirebaseAuth.User
}

protocol CheckerServiceProtocol {
    static func checkCredentials(email: String, password: String, completion: @escaping (Result<FireBaseUser, Error>) -> Void)
    static func signUp(email: String, password: String, completion: @escaping (Result<FireBaseUser, Error>) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    
    static func checkCredentials(email: String, password: String, completion: @escaping (Result<FireBaseUser, Error>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let thisError = error  {
                completion(.failure(thisError))
            }
            
            if let authResult = result {
                completion(.success(FireBaseUser(user: authResult.user)))
            }
        }
    }
    
    static func signUp(email: String, password: String, completion: @escaping (Result<FireBaseUser, Error>) -> Void) {
       
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let thisError = error {
                completion(.failure(thisError))
            }
            
            if let authResult = result {
                completion(.success(FireBaseUser(user: authResult.user)))
            }
        }
    }
    
    static func signOut() {
        guard FirebaseAuth.Auth.auth().currentUser == nil else { return }
        do {
            try? Auth.auth().signOut()
        }
    }
}
