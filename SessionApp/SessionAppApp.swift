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
    @StateObject private var authManager = AuthManager()
    
    init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(
                for: User.self,
                SessionEntry.self,
                FeelingEntry.self,
                JournalEntry.self,
                Reminder.self,
                configurations: config
            )
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            LoaderView()
                .environmentObject(authManager)
        }
        .modelContainer(container)
    }
}
