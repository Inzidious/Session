//
//  ContentView.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let user: User
    @Query private var users: [User]
    var body: some View {
        TabView
        {
            ViewC()
                .tabItem
                {
                    Image(systemName: "house.circle.fill")
                    Text("Home")
                }
            ViewB()
                .tabItem()
                {
                    Image(systemName: "map.circle.fill")
                    Text("Tracking")
                }
            ViewA()
                .tabItem()
                {
                    Image(systemName:"slider.horizontal.3")
                    Text("Resources")
                }
            CommunityView()
                .tabItem()
                {
                    Image(systemName:"person.2.fill")
                    Text("Community")
                }
        }
    }
}

let previewUser = User(
    id: UUID().uuidString,
    email: "preview@example.com",
    firstName: "Preview",
    lastName: "User",
    authProvider: "preview"
)

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: User.self,
        SessionEntry.self,
        FeelingEntry.self,
        configurations: config
    )
    
    ContentView(user: previewUser)
        .modelContainer(container)
}
