//
//  HeaderDescriber.swift
//  TemplateIOSApplication
//
//  Created by Nguyen Thien on 05/11/2023.
//

// Policy of API Endpoint template
protocol HeaderDescriber {

    // Version number of the hosting app
    var appVersion: String { get }

    // Build number of the hosting app
    var appBuildNumber: String { get }

    // Name of the hosting app
    var appName: String { get }

    // Bundle ID of the hosting app
    var appBundleId: String { get }

    // Full computed user agent
    var userAgent: String { get }
}

