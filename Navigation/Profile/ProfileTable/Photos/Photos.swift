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
        [
            Photos(image: "firImage"),
            Photos(image: "firImage"),
            Photos(image: "firImage"),
            Photos(image: "firImage"),
            Photos(image: "firImage")
        ]
    }
}
