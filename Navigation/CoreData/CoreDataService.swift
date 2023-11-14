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
    var context: NSManagedObjectContext { get }
    func saveContext()
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
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
                assertionFailure("Save error")
            }
        }
    }
}

private extension String {
    static let coreDataBaseName = "SharedPostBase"
}
