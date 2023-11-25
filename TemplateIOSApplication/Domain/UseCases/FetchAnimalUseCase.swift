//
//  FetchAnimalUseCase.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 02/11/2023.
//

import Foundation

protocol FetchAnimalUseCase {
    func getAnimals() async -> [Animal]
    func getMore() async -> [Animal]
    func deleteAnimal(_ animal: Animal)
    func searchAnimals(_ str: String) async -> [Animal]
}

class FetchAnimalUseCaseIml: FetchAnimalUseCase {
    private let repository: AnimalRepository
    
    init(repo: AnimalRepository) {
        self.repository = repo
    }
    
    func getAnimals() async -> [Animal] {
        await repository.getAnimals()
    }
    
    func getMore() async -> [Animal] {
        await repository.getMore()
    }
    
    func deleteAnimal(_ animal: Animal) {
        repository.deleteAnimal(animal)
    }
    
    func searchAnimals(_ str: String) async -> [Animal] {
        await repository.searchAnimals(str)
    }
}
