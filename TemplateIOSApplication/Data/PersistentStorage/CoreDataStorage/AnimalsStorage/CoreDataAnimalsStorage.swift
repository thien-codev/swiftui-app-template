//
//  CoreDataAnimalsStorage.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 10/11/2023.
//

import Foundation
import CoreData

final class CoreDataAnimalsStorage: AnimalsStorage {
    
    private let coreDataStorage: CoreDataStorageStack
    
    init(coreDataStorage: CoreDataStorageStack) {
        self.coreDataStorage = coreDataStorage
    }
    
    private func fetchRequest() -> NSFetchRequest<AnimalEntity> {
        let request = AnimalEntity.fetchRequest()
        return request
    }
    
    private func deleteResponse(to animals: [Animal]) {
        coreDataStorage.performBackgroundTask { [weak self] context in
            guard let self else { return }
            do {
                let fetchRequest = self.fetchRequest()
                let animalEntities = try context.fetch(fetchRequest)
                for item in animalEntities {
                    if animals.contains(where: { item.id == $0.id }) {
                        context.delete(item)
                    }
                }
            } catch {
                debugPrint("\(#function) ---> error: \(error)")
            }
        }
    }
    
    func fetchAnimals() async -> [Animal] {
        await withCheckedContinuation { continuation in
            coreDataStorage.performBackgroundTask { [weak self] context in
                guard let self else { return }
                do {
                    let animalEntities = try context.fetch(self.fetchRequest())
                    continuation.resume(returning: animalEntities.compactMap({ $0.toAnimal }))
                } catch {
                    debugPrint("\(#function) ---> error: \(error)")
                    continuation.resume(returning: [])
                }
            }
        }
    }
    
    func save(_ list: [Animal]) {
        coreDataStorage.performBackgroundTask { [weak self] context in
            guard let self else { return }
            self.deleteResponse(to: list)
            do {
                for item in list {
                    let _ = item.toEntity(in: context)
                    try context.save()
                }
            } catch {
                debugPrint("\(#function) ---> error: \(error)")
            }
        }
    }
    
    func delete(_ animal: Animal) {
        print("=== delete cache animal \(String(describing: animal.id))")
    }
    
    func search(_ str: String) async -> [Animal] {
        let caches = await fetchAnimals()
        if str.isEmpty {
            return caches
        } else {
            return caches.filter({ $0.id?.contains(str) == true })
        }
    }
}
