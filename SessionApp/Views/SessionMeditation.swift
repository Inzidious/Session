//
//  SessionMeditation.swift
//  SessionApp
//
//  Created by macOS on 2/8/25.
//



import SwiftUI

struct SessionMeditation: View {
    @StateObject private var store = RecordingStore()
    @State private var selectedCategory: Category = .top
    @Binding var assetCategory: String
    @Environment(\.dismiss) private var dismiss
    
    var filteredAssets: [AudioAsset] {
        store.filteredAssets(type: .meditation, category: selectedCategory)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    // Left padding with specific width
                    Spacer().frame(width: 60)  // This creates 60 points of space from the left edge
                    
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color(.systemBrown).opacity(0.5))
                            .scaleEffect(2.0)
                    }
                    
                    Spacer()
                    
                    // Right-aligned logo
                    Image("header_meditation")
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
                .background(Color(.systemBrown).opacity(0.2))
                
                // Session List
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(filteredAssets) { asset in
                            AudioSessionCard(asset: asset)
                        }
                    }
                    .padding()
                }

                
            }
            .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        }
    }
}

#Preview {
    SessionMeditation(assetCategory: .constant(""))
}
