//
//  SessionAppApp.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/11/24.
//  Update by Ahmed Shuja on 2/18/25

import SwiftUI
import SwiftData

@main
struct SessionAppApp: App {
    let container: ModelContainer
    
    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(
                for: User.self,
                SessionEntry.self,
                FeelingEntry.self,
                JournalEntry.self,
                configurations: config
            )
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LoaderView()
        }
        .modelContainer(container)
    }
}
