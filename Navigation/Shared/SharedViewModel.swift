//
//  SharedViewModel.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import Foundation

final class SharedViewModel {

    private let coordinator: SharedCoordinatorProtocol
    
    init(coordinator: SharedCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func postCount() -> Int {
        SharedService.shared.sharedPosts.count
    }
    
    func selectPost(selectRow: Int) -> SharedPost {
        SharedService.shared.sharedPosts[selectRow]
    }
    
    func deletePost(selectRow: Int, completion: @escaping ([SharedPost]) -> Void) {
        let post = selectPost(selectRow: selectRow)
        SharedService.shared.deletePost(post: post) { result in
            completion(result)
        }
    }
    
    func setFilter(completion: @escaping () -> Void) {
        coordinator.showSetFilter {
            completion()
        }
    }
    
    func cancelFilter(completion: @escaping () -> Void) {
        SharedService.shared.loadPosts { _ in
            completion()
        }        
    }
}
