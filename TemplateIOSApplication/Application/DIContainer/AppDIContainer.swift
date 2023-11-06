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
        AnimalRepositoryIml(dataTransferService: DefaultDataTransferService(service: DefaultNetworkService()))
    }()
    
    lazy var animalUseCase: FetchAnimalUseCase = {
        FetchAnimalUseCaseIml(repo: animalRepo)
    }()
    
    lazy var networkTestVM: NetworkTestVM = {
        NetworkTestVM(useCases: animalUseCase)
    }()
}
