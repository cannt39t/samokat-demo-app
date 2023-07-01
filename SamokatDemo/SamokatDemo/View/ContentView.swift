//
//  ContentView.swift
//  SamokatDemo
//
//  Created by Илья Казначеев on 28.06.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var alertManager: DishCartPresentManager = .init()
    var body: some View {
        TabBarView()
            .environmentObject(alertManager)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
