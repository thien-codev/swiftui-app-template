//
//  FetchAnimalUseCase.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 02/11/2023.
//

import Foundation

protocol FetchAnimalUseCase {
    func getAnimals() async -> [Animal]
}

class FetchAnimalUseCaseIml: FetchAnimalUseCase {
    private let repository: AnimalRepository
    
    init(repo: AnimalRepository) {
        self.repository = repo
    }
    
    func getAnimals() async -> [Animal] {
        await repository.getAnimals()
    }
}
