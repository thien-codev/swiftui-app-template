//
//  HeaderBuilder.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 05/11/2023.
//

import Foundation

struct HeaderBuilder {
    
    // Dummy header
    enum HeaderProperty: String {
        case timezone = "X-App-TimeZone"
        case version = "X-App-Version"
        case buildNumber = "X-App-Build"
        case language = "Accept-Language"
        case accessToken = "Authorization"
        
        var key: String {
            rawValue
        }
    }
    
    private let authorizationPrefix = "Bearer "
    private let headerDescriber: HeaderDescriber
    
    init(headerDescriber: HeaderDescriber) {
        self.headerDescriber = headerDescriber
    }
    
    var accessToken: String?
    
    mutating func with(accessToken: String) -> Self {
        self.accessToken = accessToken
        return self
    }
    
    func build() -> [String: String] {
        var headers: [String: String] = [
            HeaderProperty.timezone.key: TimeZone.current.identifier,
            HeaderProperty.version.key: headerDescriber.appVersion,
            HeaderProperty.buildNumber.key: headerDescriber.appBuildNumber,
            HeaderProperty.language.key: "en" // Temporary language
        ]
        
        if let accessToken {
            headers[HeaderProperty.accessToken.key] = accessToken
        }
        
        return headers
    }
}
