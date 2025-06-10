//
//  AudioComponents.swift
//  SessionApp
//
//  Created by macOS on 2/10/25.
//


import SwiftUI

struct AudioCategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(isSelected ? .black : .gray)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(
                    isSelected ?
                    Color(.systemBrown).opacity(0.2) :
                    Color.clear
                )
                .cornerRadius(20)
        }
    }
}

struct AudioSessionCard: View {
    let asset: AudioAsset
    @State private var showingPlayer = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(asset.title)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack {
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(Color(.systemBrown))
                        .font(.title2)
                    Text(formatDuration(asset.duration))
                        .foregroundColor(.gray)
                }
            }
            .padding()
            
            Spacer()
            
            Image(asset.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipped()
        }
        .frame(height: 100)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
        .onTapGesture {
            showingPlayer = true
        }
        .sheet(isPresented: $showingPlayer) {
            FullPlayerView(assetToPlay:GlobalManifest.shared.manifest[0])
        }
    }
    
    private func formatDuration(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        return "\(minutes) min"
    }
}

struct BreathingToolButton: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Breathing Tool")
                        .font(.custom("OpenSans-SemiBold", size: 18))
                        .foregroundColor(.black)
                }
                .padding()
                Spacer()
            }
            .frame(height: 100)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2)
            
            // Your custom image in the top-right
            Image("Breath_a159")
                .resizable()
                .frame(width: 53, height: 53) // or adjust as needed
                .padding(8)
        }
        .frame(height: 100)
    }
}



