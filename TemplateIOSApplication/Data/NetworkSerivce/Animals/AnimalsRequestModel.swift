//
//  AnimalsRequestModel.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 06/11/2023.
//

import Foundation

struct AnimalsRequestModel: Encodable {
    let limit: Int
    
    var queryParams: String {
        guard let param = jsonDict?.queryString else { return ""}
        return param
    }
}

