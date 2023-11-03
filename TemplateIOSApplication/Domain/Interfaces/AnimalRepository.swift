//
//  AnimalRepository.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 02/11/2023.
//

import Foundation

protocol AnimalRepository {
    func getAnimals() async -> [Animal]
}
