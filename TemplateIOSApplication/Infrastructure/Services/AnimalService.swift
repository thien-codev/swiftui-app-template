//
//  AnimalService.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

protocol AnimalServiceExpected {
    var network: NetworkType { get }
    func getAnimals() async -> [Animal]
}

class AnimalService: AnimalServiceExpected {
    
    var network: NetworkType
    
    init(network: NetworkType) {
        self.network = network
    }
    
    func getAnimals() async -> [Animal] {
        let requestModel = ListAnimalRequestModel(limit: 10) // temporary: limit = 10
        let resource = Resource<[Animal]>(endpoint: AnimalURL.imageSearch(params: requestModel.queryParams), method: .get, thread: .global()) { [weak self] data in
            self?.network.decode(data: data) ?? []
        }
        
        do {
            let animals = try await network.request(resource: resource, timeout: nil)
            return animals
        } catch {
            print("=== error: \(error.localizedDescription)")
            return []
        }
    }
}
