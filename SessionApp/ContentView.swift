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
    @EnvironmentObject var authManager: AuthManager
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .environmentObject(authManager)
                .tabItem {
                    Image(systemName: "heart.circle")
                    Text("Home")
                }
                .tag(0)
            
            ViewA()
                .environmentObject(authManager)
                .tabItem {
                    Image(systemName:"heart.fill")
                    Text("Resources")
                }
                .tag(1)
            
            ViewB()
                .environmentObject(authManager)
                .tabItem {
                    Image(systemName: "map.circle.fill")
                    Text("Tracking")
                }
                .tag(2)
            
            CommunityView()
                .environmentObject(authManager)
                .tabItem {
                    Image(systemName:"globe.americas.fill")
                    Text("Community")
                }
                .tag(3)
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
    
    return ContentView(user: previewUser)
        .modelContainer(container)
        .environmentObject(AuthManager())
}
