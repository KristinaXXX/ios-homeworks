//
//  Photos.swift
//  Navigation
//
//  Created by Kr Qqq on 01.07.2023.
//

import Foundation

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
}
