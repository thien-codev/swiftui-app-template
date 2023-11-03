//
//  Encodable.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

extension Encodable {
    var jsonDict: JSONDictionary? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSONDictionary
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}
