//
//  ViewA.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/15/24.
//

import SwiftUI
import SwiftData

struct ViewA: View {
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Add this property to define colors for each topic
    private let topicColors: [Color] = [
        Color(red: 207/255, green: 90/255, blue: 87/255), // Red
        Color(red: 120/255, green: 165/255, blue: 163/255), // Teal
        Color(red: 225/255, green: 177/255, blue: 106/255), // mustard
        Color(red: 161/255, green: 190/255, blue: 149/255), // lime green
        Color(red: 66/255, green: 111/255, blue: 135/255), // Light Purple
        Color(red: 207/255, green: 90/255, blue: 87/255), // Red
        Color(red: 120/255, green: 165/255, blue: 163/255), // Teal
        Color(red: 225/255, green: 177/255, blue: 106/255), // mustard
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Updated header with both icons
                HStack {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.circle.fill")
                            .scaleEffect(1.9)
                            .font(.title2)
                            .symbolRenderingMode(.palette) // Enable multi-color support
                            .foregroundStyle(
                                Color(red: 225/255, green: 178/255, blue: 107/255), // Foreground color
                                Color(red: 249/255, green: 240/255, blue: 276/255)  // Background color
                            )
                    }
                    .padding(.leading, 20)
                    Spacer()
                    
                    NavigationLink(destination: CreateReminderView()) {
                        Image(systemName: "bell.badge.fill")
                            .scaleEffect(1.3)
                            .font(.title2)
                            .symbolRenderingMode(.palette) // Enable multi-color support
                            .foregroundStyle(
                                Color(red: 249/255, green: 240/255, blue: 276/255), // Foreground color
                                Color(red: 225/255, green: 178/255, blue: 107/255)// Background color
                            )
                                
                    }
                }
                .padding(.horizontal, 20)
                .padding(.trailing, 20)

                HStack {
                    Image("icon_resources")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    
                    Text("Resources")
                        .foregroundColor(.black)
                        .font(.openSansSoftBold(size: 40))
                }
                .padding(20)
                .frame(width:350, height:50, alignment: .trailing)
                
                // New grid layout with floating rectangles
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(zip(resourceTopics, topicColors)), id: \.0) { topic, color in
                        NavigationLink(destination: ResourceDetails(selectedTopic: topic)) {
                            ResourceBox(title: topic, backgroundColor: color)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            .background(Color("BGColor").ignoresSafeArea())
            .onAppear {
                for family in UIFont.familyNames.sorted() {
                    let names = UIFont.fontNames(forFamilyName: family)
                    print("Family: \(family) Font names: \(names)")
                }
            }
        }
    }
    
    private let resourceTopics = [
        "Feelings",
        "Problem Solving",
        "Stress",
        "Depression",
        "Communication",
        "Anxiety",
        "Grief",
        "Anger Management"
    ]
}

// New ResourceBox view component
struct ResourceBox: View {
    let title: String
    let backgroundColor: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .medium))
            .multilineTextAlignment(.center)
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .shadow(color: Color.gray.opacity(0.3),
                           radius: 5, x: 0, y: 2)
            )
            .foregroundColor(.black)
            .padding(.horizontal, 5)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    if let container = try? ModelContainer(for: SessionEntry.self,
                                         FeelingEntry.self,
                                         configurations: config) {
        return ViewA().modelContainer(container)
    } else {
        return Text("Failed to create container")
    }
}
