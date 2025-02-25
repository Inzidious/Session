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
                .padding(.leading, 25)
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
            .padding(.horizontal, 10)
            //.padding(.top, 5)
            .padding(.trailing, 25)
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
                    }
                }
                .padding(.leading, 10)
                Spacer()
            }
            .padding(.top, 5)
            
            // Header image
            Image("header_meditation")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 45 * 1.25)
                .scaleEffect(1.25)
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
            .background(Color(#colorLiteral(red: 0.631372549, green: 0.7450980392, blue: 0.5843137255, alpha: 1)).opacity(0.2))
            
            // Session List
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(filteredAssets) { asset in
                        AudioSessionCard(asset: asset)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarHidden(true)
        .background(Color(#colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9647058824, alpha: 1)))
    }
}

#Preview {
    SessionMeditation(assetCategory: .constant(""))
}
