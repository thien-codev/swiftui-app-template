//
//  Animal.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 02/11/2023.
//

import Foundation

struct Animal: Codable {
    let id: String?
    let url: String?
    let width, height: Double
    let mimeType: String?
    let breeds: [Breed]?
    let categories: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, url, width, height
        case mimeType = "mime_type"
        case breeds, categories
    }
}

struct Breed: Codable {
    let id: Int
    let name, weight, height, lifeSpan: String
    let breedGroup: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, weight, height
        case lifeSpan = "life_span"
        case breedGroup = "breed_group"
    }
}
