//
//  AppDIContainer.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

class AppDIContainer: ObservableObject {
    struct Dependencies {
        var animalService: AnimalServiceExpected
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    lazy var animalRepo: AnimalRepository = {
        AnimalRepositoryIml(service: dependencies.animalService)
    }()
    
    lazy var animalUseCase: FetchAnimalUseCase = {
        FetchAnimalUseCaseIml(repo: animalRepo)
    }()
    
    lazy var networkTestVM: NetworkTestVM = {
        NetworkTestVM(useCases: animalUseCase)
    }()
}
