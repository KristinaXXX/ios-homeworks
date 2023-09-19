//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Kr Qqq on 19.09.2023.
//

import Foundation

final class FeedViewModel {

    private let feedModel: FeedModel
    private let coordinator: FeedCoordinatorProtocol
    
    init(feedModel: FeedModel, coordinator: FeedCoordinatorProtocol) {
        self.feedModel = feedModel
        self.coordinator = coordinator
    }
    
    func checkWordShowResult(_ word: String) {
        let result = feedModel.check(word: word)
        coordinator.showCheckResult(result: result)
    }
    
    func showPost(text: String) {
        coordinator.showPost(post: feedModel.takePost(text: text))        
    }
}
