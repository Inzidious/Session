//
//  SessionListView.swift
//  SessionApp
//
//  Created by macOS on 2/8/25.
//


import SwiftUI

// Add import for AudioComponents if needed
// import AudioComponents  // Only if components are in a separate module

struct SessionListView: View {
    @StateObject private var store = RecordingStore()
    @State private var selectedCategory: Category = .top
    @Binding var assetCategory: String
    let assetType: AssetType
    @Environment(\.dismiss) private var dismiss
    
    var filteredAssets: [AudioAsset] {
        store.filteredAssets(type: assetType, category: selectedCategory)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // Top icons HStack - kept in safe area
            HStack {
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.circle.fill")
                        .scaleEffect(1.9)
                        .font(.title2)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color(red: 225/255, green: 178/255, blue: 107/255),
                            Color(red: 249/255, green: 240/255, blue: 276/255)
                        )
                }
                .padding(.leading, 15)
                Spacer()
                
                NavigationLink(destination: CreateReminderView()) {
                    Image(systemName: "bell.badge.fill")
                        .scaleEffect(1.3)
                        .font(.title2)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color(red: 249/255, green: 240/255, blue: 276/255),
                            Color(red: 225/255, green: 178/255, blue: 107/255)
                        )
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            .padding(.trailing, 10)
            .background(
                Color(#colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9647058824, alpha: 1))
                    .opacity(0.2)
                    .ignoresSafeArea(edges: .top)
            )
            
            // Custom back button below the top icons
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left.circle")
                            .font(.title2)
                            .foregroundColor(Color(#colorLiteral(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745, alpha: 1)))
                            .scaleEffect(1.25)
                        //Text("Back")
                          //  .foregroundColor(.blue)
                    }
                }
                .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 5)
            
            // Rest of your content
            Image("header_breath")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 45 * 1.25)
                .scaleEffect(1.5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
            
            // Category bar with tan background
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Category.allCases, id: \.self) { category in
                        AudioCategoryButton(
                            title: category.rawValue,
                            isSelected: category == selectedCategory
                        ) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color(#colorLiteral(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745, alpha: 1)).opacity(0.2))
            
            // Session List
            ScrollView {
                VStack(spacing: 15) {
                    // Breathing Tool Button
                    NavigationLink(destination: BreathView()) {
                        BreathingToolButton()
                    }
                    .padding(.horizontal)
                    
                    // Asset List
                    LazyVStack(spacing: 15) {
                        ForEach(filteredAssets) { asset in
                            AudioSessionCard(asset: asset)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .background(Color(#colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9647058824, alpha: 1)))
        .navigationBarHidden(true) // This will hide the default back button
    }
    
}

#Preview {
    SessionListView(assetCategory: .constant(""), assetType: .breathing)
} 
