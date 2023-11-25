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
    
    let appDIContainer: AppDIContainer

    var body: some Scene {
        WindowGroup {
            OnboardingView().environmentObject(appDIContainer.animalsViewVM)
        }
    }
}
