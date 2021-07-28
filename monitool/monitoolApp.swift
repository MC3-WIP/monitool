//
//  monitoolApp.swift
//  monitool
//
//  Created by Christianto Budisaputra on 21/07/21.
//

import SwiftUI
import Firebase

@main
struct monitoolApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onChange(of: /*@START_MENU_TOKEN@*/"Value"/*@END_MENU_TOKEN@*/, perform: { value in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                })
        }
    }
}
