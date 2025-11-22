//
//  Taraz_AkimatApp.swift
//  Taraz Akimat
//
//  Created by Жарбол Ермаганбет on 22.11.2025.
//

import SwiftUI

@main
struct Taraz_AkimatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
