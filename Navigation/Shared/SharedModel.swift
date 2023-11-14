//
//  SharedModel.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import CoreData
import Foundation
import StorageService

final class SharedModel {
    
    private let coreDataService: ICoreDataService = CoreDataService.shared
    
    private(set) var sharedPosts = [SharedPost]()
    
    init() {
        loadPosts()
    }
    
    func getPosts() -> [SharedPost] {
        sharedPosts
    }
    
    func loadPosts() {
        let request = SharedPost.fetchRequest()
        do {
            sharedPosts = try coreDataService.context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func savePost(post: Post) {
        let newPost = SharedPost(context: coreDataService.context)
        newPost.author = post.author
        newPost.description_ = post.description
        newPost.image = post.image
        newPost.likes = Int16(post.likes)
        newPost.views = Int16(post.views)
        newPost.id = post.id
        coreDataService.saveContext()
        loadPosts()
    }
    
    func deletePost(post: Post) {
        let posts = sharedPosts.filter{ $0.id == post.id }
        for findPost in posts {
            coreDataService.context.delete(findPost)
        }
        coreDataService.saveContext()
        loadPosts()
    }
    
    func deletePost(post: SharedPost) {
        coreDataService.context.delete(post)
        coreDataService.saveContext()
        loadPosts()
    }
    
    func isSaved(post: Post) -> Bool {
        let posts = sharedPosts.filter{ $0.id == post.id }
        return !posts.isEmpty
    }    
}
