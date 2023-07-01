//
//  SamokatDemoApp.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 28.06.2023.
//

import SwiftUI

@main
struct SamokatDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
