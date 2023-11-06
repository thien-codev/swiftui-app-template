//
//  APIEndpint.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 06/11/2023.
//

import Foundation

struct APIEndpoint {
    
    static var animals: Endpoint<[Animal]> = {
        Endpoint<[Animal]>(baseURL: AnimalURL.animals.baseUrlString,
                           path: AnimalURL.animals.pathString,
                           method: .get,
                           queryParamatersEncodable: ListAnimalRequestModel(limit: 10))
    }()
    
    static var animalDetail: Endpoint<Animal> = {
        Endpoint<Animal>(baseURL: AnimalURL.animalDetail.baseUrlString,
                         path: AnimalURL.animalDetail.pathString,
                         method: .get)
    }()
}
