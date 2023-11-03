//
//  HeaderDescriberIml.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 05/11/2023.
//

import Foundation

class HeaderDescriberIml: HeaderDescriber {
    
    var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var appBuildNumber: String {
        Bundle.main.infoDictionary?[String(kCFBundleVersionKey)] as? String ?? ""
    }
    
    var appName: String {
        Bundle.main.infoDictionary?[String(kCFBundleExecutableKey)] as? String ?? ""
    }
    
    var appBundleId: String {
        Bundle.main.infoDictionary?[String(kCFBundleIdentifierKey)] as? String ?? ""
    }
    
    // leave if empty if unnecessary
    var userAgent: String {
        return .init()
    }
}
