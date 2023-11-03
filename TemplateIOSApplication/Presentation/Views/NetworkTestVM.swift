//
//  NetworkTestVM.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

class NetworkTestVM: ObservableObject {
    
    private let useCases: FetchAnimalUseCase

    @Published var animals: [Animal] = []
    
    init(useCases: FetchAnimalUseCase) {
        self.useCases = useCases
        
        Task {
            await self.getAnimals()
        }
    }
    
    @MainActor
    func getAnimals() async {
        animals = await useCases.getAnimals()
    }
}
