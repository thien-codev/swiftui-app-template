//
//  AnimalRepository.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

class AnimalRepositoryIml: AnimalRepository {
    
    let animalService: AnimalServiceExpected
    
    init(service: AnimalServiceExpected) {
        self.animalService = service
    }
    
    func getAnimals() async -> [Animal] {
        await animalService.getAnimals()
    }
}
