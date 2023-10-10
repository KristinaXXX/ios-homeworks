//
//  Photos.swift
//  Navigation
//
//  Created by Kr Qqq on 01.07.2023.
//

import Foundation
import UIKit

struct Photos {
    let image: String
}

extension Photos {
    static func make() -> [Photos] {
        var photoArray: [Photos] = []
        for i in 1...20 {
            photoArray.append(Photos(image: "house_\(i)"))
        }
        return photoArray
    }
    
    static func makeImage(completion: @escaping (Result<[UIImage], PhotosError>) -> Void) {
        
        let randomInt = Int.random(in: 0...3)
        
        switch randomInt {
        case 0:
            var photoArray: [UIImage] = []
            for i in 1...20 {
                photoArray.append(UIImage(named: "house_\(i)") ?? UIImage())
            }
            completion(.success(photoArray))
        case 1:
            completion(.failure(.badRequest))
        case 2:
            completion(.failure(.forbidden))
        default:
            completion(.failure(.notFound))
        }

    }
}
