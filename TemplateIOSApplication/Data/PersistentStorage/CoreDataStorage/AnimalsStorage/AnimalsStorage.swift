//
//  AnimalsStorage.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 09/11/2023.
//

import Foundation

protocol AnimalsStorage {
    func fetchAnimals() async -> [Animal]
    func delete(_ animal: Animal)
    func search(_ str: String) async -> [Animal]
    func save(_ list: [Animal])
}
