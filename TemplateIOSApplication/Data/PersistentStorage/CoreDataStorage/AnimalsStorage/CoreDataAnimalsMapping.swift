//
//  CoreDataAnimalsMapping.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 12/11/2023.
//

import Foundation
import CoreData

extension AnimalEntity {
    var toAnimal: Animal {
        return Animal(id: id,
                      url: name,
                      width: width,
                      height: height,
                      mimeType: mimeType,
                      breeds: nil,
                      categories: nil)
    }
}

extension Animal {
    func toEntity(in context: NSManagedObjectContext) -> AnimalEntity {
        
        let entity: AnimalEntity = .init(context: context)
        
        entity.id = id
        entity.name = url
        entity.width = width
        entity.height = height
        entity.mimeType = mimeType
        
        return entity
    }
}
