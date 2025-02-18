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
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    // user profile icon
                    Image(systemName: "person.circle.fill")
                        .font(.title2)
                        .foregroundColor(Color(.systemBrown).opacity(0.5))
                        .scaleEffect(2.0)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    // Right-aligned logo
                    Image("header_breath")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)  // Make it larger
                        .padding(.trailing, 50)  // Push it right but leave space for menu
                    
                    // Menu button
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                    }
                }
                .padding()
                .background(Color.white)
                
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
                .background(Color(#colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9647058824, alpha: 1)).opacity(0.2))
                
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
            .background(Color(#colorLiteral(red: 0.631372549, green: 0.7450980392, blue: 0.5843137255, alpha: 1)))
        }
    }
}

#Preview {
    SessionListView(assetCategory: .constant(""), assetType: .breathing)
} 
