//
//  BudgetInHandApp.swift
//  BudgetInHand
//
//  Created by Cédric Debroux on 25/11/2022.
//

import SwiftUI

@main
struct BudgetInHandApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
