//
//  BMITrackerApp.swift
//  BMITracker
//
//  Created by Cesar Ibarra on 1/7/22.
//

import SwiftUI

@main
struct BMITrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
