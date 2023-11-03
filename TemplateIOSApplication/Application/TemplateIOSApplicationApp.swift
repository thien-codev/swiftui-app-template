//
//  TemplateIOSApplicationApp.swift
//  TemplateIOSApplication
//
//  Created by ndthien01 on 02/11/2023.
//

import SwiftUI

@main
struct TemplateIOSApplicationApp: App {
    
    init() {
        appDIContainer = AppDIContainer(dependencies: .init(animalService: AnimalService(network: Network())))
    }
    
    let persistenceController = PersistenceController.shared
    let appDIContainer: AppDIContainer

    var body: some Scene {
        WindowGroup {
            NetworkTestView().environmentObject(appDIContainer.networkTestVM)
        }
    }
}
