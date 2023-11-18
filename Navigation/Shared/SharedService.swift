//
//  SharedModel.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import CoreData
import Foundation
import StorageService

final class SharedService {
    
    private let coreDataService: ICoreDataService = CoreDataService.shared
    static let shared: SharedService = SharedService()
    
    private(set) var sharedPosts = [SharedPost]()
    
    init() {
        loadPosts { [weak self] result in
            self?.sharedPosts = result
        }
    }
    
    func loadPosts(completion: @escaping ([SharedPost]) -> Void) {

        coreDataService.backgroundContext.perform { [weak self] in
            guard let self else { return }
            let request = SharedPost.fetchRequest()
            
            do {
                sharedPosts = try coreDataService.backgroundContext.fetch(request).map { $0 }
                coreDataService.mainContext.perform { [weak self] in
                    guard let self else { return }
                    completion(sharedPosts)
                }
            } catch {
                print(error)
                sharedPosts = []
                completion(sharedPosts)
            }
        }
    }
    
    func savePost(post: Post, completion: @escaping ([SharedPost]) -> Void) {
        
        coreDataService.backgroundContext.perform { [weak self] in
            guard let self else { return }
            
            let newPost = SharedPost(context: coreDataService.backgroundContext)
            newPost.author = post.author
            newPost.description_ = post.description
            newPost.image = post.image
            newPost.likes = Int16(post.likes)
            newPost.views = Int16(post.views)
            newPost.id = post.id
            
            if coreDataService.backgroundContext.hasChanges {
                do {
                    try coreDataService.backgroundContext.save()
                    coreDataService.mainContext.perform { [weak self] in
                        guard let self else { return }
                        sharedPosts.insert(newPost, at: 0)
                        completion(sharedPosts)
                    }
                } catch {
                    coreDataService.mainContext.perform { [weak self] in
                        guard let self else { return }
                        completion(sharedPosts)
                    }
                }
            }
        }
    }
    
    func deletePost(post: SharedPost, completion: @escaping ([SharedPost]) -> Void) {
        
        coreDataService.backgroundContext.perform { [weak self] in
            guard let self else { return }
            coreDataService.backgroundContext.delete(post)
             
            do {
                try coreDataService.backgroundContext.save()
                sharedPosts.removeAll(where: { $0.id == post.id })
                coreDataService.mainContext.perform { [weak self] in
                    guard let self else { return }
                    completion(sharedPosts)
                }
            } catch {
                print(error)
                coreDataService.mainContext.perform { [weak self] in
                    guard let self else { return }
                    completion(sharedPosts)
                }
            }
        }
    }
    
    func isSaved(post: Post) -> Bool {
        let posts = sharedPosts.filter{ $0.id == post.id }
        return !posts.isEmpty
    } 
    
    func setFilter(value: String, completion: @escaping ([SharedPost]) -> Void) {
        let predicate = NSPredicate(format: "author == %@", value)
        coreDataService.backgroundContext.perform { [weak self] in
            guard let self else { return }
            let request = NSFetchRequest<SharedPost>(entityName: "SharedPost")
            request.predicate = predicate
            
            do {
                sharedPosts = try coreDataService.backgroundContext.fetch(request).map { $0 }
                coreDataService.mainContext.perform { [weak self] in
                    guard let self else { return }
                    completion(sharedPosts)
                }
            } catch {
                print(error)
                sharedPosts = []
                completion(sharedPosts)
            }
        }
    }
}
