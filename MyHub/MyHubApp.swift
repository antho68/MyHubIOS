//
//  MyHubApp.swift
//  MyHub
//
//  Created by Anthony Baumle on 03/04/2023.
//

import SwiftUI

@main
struct MyHubApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
