//
//  ContentView.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/11/24.
//

import SwiftUI

struct ContentView: View {
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

#Preview {
    ContentView()
}
