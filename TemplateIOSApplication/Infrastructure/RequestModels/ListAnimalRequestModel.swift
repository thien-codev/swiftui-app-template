//
//  ListAnimalRequestModel.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

struct ListAnimalRequestModel: Encodable {
    let limit: Int
    
    var queryParams: String {
        guard let param = jsonDict?.queryString else { return ""}
        return param
    }
}
