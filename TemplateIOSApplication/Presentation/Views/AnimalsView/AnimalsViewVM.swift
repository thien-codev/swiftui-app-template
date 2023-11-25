//
//  AnimalsViewVM.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

class AnimalsViewVM: ObservableObject {
    
    private let useCases: FetchAnimalUseCase

    @Published var animals: [Animal] = []
    @Published var showLoading: Bool = false
    @Published var text: String = .init() {
        didSet {
            Task { @MainActor in
                animals = await search(from: text)
            }
        }
    }
    
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
    
    func delete(_ animal: Animal) {
        useCases.deleteAnimal(animal)
    }
    
    func search(from str: String) async -> [Animal] {
        await useCases.searchAnimals(str)
    }
    
    @MainActor
    func getMore() async {
        showLoading = true
        animals = await useCases.getMore()
        showLoading = false
    }
}
