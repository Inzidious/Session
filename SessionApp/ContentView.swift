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
    
    init(user: User) {
        self.user = user
        
        // Configure TabBar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 250/255, green: 249/255, blue: 246/255, alpha: 1) // #faf9f6
        
        // Set the selected and unselected item colors
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .environmentObject(authManager)
                    .tabItem {
                        Image(systemName: "heart.circle")
                        Text("Home")
                    }
                    .tag(0)
                
                ResourceView()
                    .environmentObject(authManager)
                    .tabItem {
                        Image(systemName:"heart.fill")
                        Text("Resources")
                    }
                    .tag(1)
                
                MoodTracking()
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
            
            // Custom Tab Bar Indicator
            GeometryReader { geometry in
                let tabWidth = geometry.size.width / 4
                
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: tabWidth - 20, height: 55)
                    .cornerRadius(8)
                    .offset(x: CGFloat(selectedTab) * tabWidth + 10)
                    .animation(.spring(), value: selectedTab)
            }
            .frame(height: 45)
            .padding(.bottom, 5) // Adjust this value to position the indicator above the tab bar
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
