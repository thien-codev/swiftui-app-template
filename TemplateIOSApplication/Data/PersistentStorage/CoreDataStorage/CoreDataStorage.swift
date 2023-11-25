//
//  CoreDataStorage.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 09/11/2023.
//

import Foundation
import CoreData

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}

class CoreDataStorageStack {
    
    static var manager = CoreDataStorageStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "TemplateIOSApplication")
        
        persistentContainer.loadPersistentStores { _, error in
            
            guard let error else {
                debugPrint("\(self) ---> success")
                return
            }
            debugPrint("\(self) ---> error: \(error)")
        }
        
        return persistentContainer
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                debugPrint("\(#function) ---> error: \(error)")
            }
        }
    }
    
    func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}
