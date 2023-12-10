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
    
    var backgroundContext: NSManagedObjectContext {
        return coreDataService.backgroundContext
    }
    
    func savePost(post: Post) {
        if isSaved(post: post) {
            return
        }
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
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deletePost(post: SharedPost) {
        coreDataService.backgroundContext.perform { [weak self] in
            guard let self else { return }
            coreDataService.backgroundContext.delete(post)
            do {
                try coreDataService.backgroundContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func isSaved(post: Post) -> Bool {        
        let request = SharedPost.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", post.id as CVarArg)
        request.predicate = predicate
        
        if let sharedPost = try? coreDataService.backgroundContext.fetch(request).first {
            return true
        }
        return false
    }
}
