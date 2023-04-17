//
//  ios_capstoneApp.swift
//  ios-capstone
//
//  Created by Akirah Dev on 09/04/23.
//  
//

import SwiftUI

@main
struct ios_capstoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            OnboardingScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
