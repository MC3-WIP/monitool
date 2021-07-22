//
//  monitoolApp.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import SwiftUI

@main
struct monitoolApp: App {
	let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
