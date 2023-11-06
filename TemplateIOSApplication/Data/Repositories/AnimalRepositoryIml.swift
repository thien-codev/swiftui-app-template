//
//  AnimalRepository.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

//class AnimalRepositoryIml: AnimalRepository {
//
//    let animalService: AnimalServiceExpected
//
//    init(service: AnimalServiceExpected) {
//        self.animalService = service
//    }
//
//    func getAnimals() async -> [Animal] {
//        await animalService.getAnimals()
//    }
//}


class AnimalRepositoryIml: AnimalRepository {

    let dataTransferService: DataTransferService

    private var currentTask: NetworkCancellable?

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }

    func getAnimals() async -> [Animal] {
        await withCheckedContinuation { continuation in
            let animalEndpoint = APIEndpoint.animals
            currentTask?.doCancel()
            currentTask = dataTransferService.request(with: animalEndpoint,
                                                      on: DispatchQueue.main) { result in
                switch result {
                case let .success(animals):
                    continuation.resume(returning: animals)
                case let .failure(error):
                    print("=== \(error)")
                    continuation.resume(returning: [])
                }
            }
        }
    }
}
