//
//  SessionAppApp.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/11/24.
//

import SwiftUI
import SwiftData

/*@main
struct SessionAppApp: App {
    
    var body: some Scene
    {
        WindowGroup
        {
            //ContentView()
            SplashScreenView()
        }.modelContainer(for:SessionEntry.self)
    }
}
*/


@main
struct SessionAppApp: App 
{
    @State private var currentUser:CurrentUser? = nil
    
    let config = ModelConfiguration(isStoredInMemoryOnly: false)
    private var container:ModelContainer
    
    init()
    {
        container = try! ModelContainer(for: FeelingEntry.self, SessionEntry.self, User.self, CurrentUser.self, configurations: config)
    }
    
    var body: some Scene
    {
        WindowGroup
        {
            //ContentView()
            SplashScreenView()
            //SplashScreenView()
            
        }.modelContainer(container)
    }
}
