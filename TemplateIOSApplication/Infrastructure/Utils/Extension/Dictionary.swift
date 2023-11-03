//
//  Dictionary.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 03/11/2023.
//

import Foundation

extension Dictionary {
    var queryString: String? {
        var components = URLComponents()
        components.queryItems = map { URLQueryItem(name: "\($0)", value: "\($1)") }
        return components.query?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
