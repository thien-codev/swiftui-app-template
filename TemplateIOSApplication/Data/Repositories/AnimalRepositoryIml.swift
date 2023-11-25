//
//  AnimalRepository.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

class AnimalRepositoryIml: AnimalRepository {
    private let dataTransferService: DataTransferService
    private let animalsStorage: AnimalsStorage
    private var currentTask: NetworkCancellable?

    init(dataTransferService: DataTransferService, animalsStorage: AnimalsStorage) {
        self.dataTransferService = dataTransferService
        self.animalsStorage = animalsStorage
    }

    func getAnimals() async -> [Animal] {
        let cacheAnimals = await animalsStorage.fetchAnimals()
        if !cacheAnimals.isEmpty {
            return cacheAnimals
        } else {
            return await fetchAnimalFromEndpoint()
        }
    }
    
    func getMore() async -> [Animal] {
        let cacheAnimals = await animalsStorage.fetchAnimals()
        let remoteAnimals = await fetchAnimalFromEndpoint()
        return cacheAnimals + remoteAnimals
    }
    
    func deleteAnimal(_ animal: Animal) {
        animalsStorage.delete(animal)
    }
    
    func searchAnimals(_ str: String) async -> [Animal] {
        await animalsStorage.search(str)
    }
}

private extension AnimalRepositoryIml {
    func fetchAnimalFromEndpoint() async -> [Animal] {
        return await withCheckedContinuation { continuation in
            let animalEndpoint = APIEndpoint.animals
            currentTask?.doCancel()
            currentTask = dataTransferService.request(with: animalEndpoint,
                                                      on: DispatchQueue.main) { result in
                switch result {
                case let .success(animals):
                    self.animalsStorage.save(animals)
                    continuation.resume(returning: animals)
                case let .failure(error):
                    debugPrint("\(#function) ---> error: \(error)")
                    continuation.resume(returning: [])
                }
            }
        }
    }
}
