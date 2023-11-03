//
//  Bundle.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

extension Bundle {
    
    struct Keys {
        static let animalBaseUrl = "AnimalBaseUrl"
    }
    
    func plistValue(_ key: String) -> String? {
        return infoDictionary?[key] as? String
    }
}
