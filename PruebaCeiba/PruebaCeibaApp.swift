//
//  PruebaCeibaApp.swift
//  PruebaCeiba
//
//  Created by July Pardo on 10/05/23.
//

import SwiftUI

@main
struct PruebaCeibaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
