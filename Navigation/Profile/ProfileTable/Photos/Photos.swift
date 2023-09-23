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
    
    static func makeImage() -> [UIImage] {
        var photoArray: [UIImage] = []
        for i in 1...20 {
            photoArray.append(UIImage(named: "house_\(i)") ?? UIImage())
        }
        return photoArray
    }
}
