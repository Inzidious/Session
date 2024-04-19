//
//  SessionAppApp.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/11/24.
//

import SwiftUI
import SwiftData

@main
struct SessionAppApp: App {
    
    var body: some Scene
    {
        WindowGroup
        {
            //ContentView()
            SplashScreenView()
        }.modelContainer(for:JournalEntryTwo.self)
    }
}
