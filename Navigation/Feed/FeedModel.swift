//
//  FeedModel.swift
//  Navigation
//
//  Created by Kr Qqq on 10.09.2023.
//

import Foundation

final class FeedModel {
    
    private let secretWord = "word"
    
    public func check(word: String) -> Bool {
        return word == secretWord
    }
}