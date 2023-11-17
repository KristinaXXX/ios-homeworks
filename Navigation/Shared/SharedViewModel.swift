//
//  SharedViewModel.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import Foundation

final class SharedViewModel {

    private let model: SharedModel
    private let coordinator: SharedCoordinatorProtocol
    private var sharedPosts = [SharedPost]()
    
    init(model: SharedModel, coordinator: SharedCoordinatorProtocol) {
        self.model = model
        self.coordinator = coordinator
        updatePosts()
    }
    
    func postCount() -> Int {
        sharedPosts.count
    }
    
    func selectPost(selectRow: Int) -> SharedPost {
        sharedPosts[selectRow]
    }
    
    func updatePosts() {
        model.loadPosts()
        sharedPosts = model.getPosts()
    }
}
