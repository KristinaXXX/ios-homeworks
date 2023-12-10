//
//  CoreDataService.swift
//  Navigation
//
//  Created by Kr Qqq on 11.11.2023.
//

import Foundation

import CoreData
import Foundation

protocol ICoreDataService {
    var mainContext: NSManagedObjectContext { get }
    var backgroundContext: NSManagedObjectContext { get }
}

final class CoreDataService: ICoreDataService {
    
    static let shared: ICoreDataService = CoreDataService()
    
    private init() {}
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: .coreDataBaseName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error)
                assertionFailure("load Persistent Stores error")
            }
        }
        return container
    }()

    lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
}

private extension String {
    static let coreDataBaseName = "SharedPostBase"
}
