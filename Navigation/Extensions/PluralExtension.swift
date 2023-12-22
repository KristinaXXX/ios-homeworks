//
//  PluralExtension.swift
//  Navigation
//
//  Created by Kr Qqq on 11.12.2023.
//

import Foundation

extension Int16 {
    var numberOfLikes: String {
        pluralString(for: "numberOfLikes", value: self)
    }    
    var numberOfViews: String {
        pluralString(for: "numberOfViews", value: self)
    }
}

func pluralString(for key: String, value: Int16) -> String {
    let format = NSLocalizedString(key, tableName: "Plurals", comment: "")
    return String(format: format, value)
}
