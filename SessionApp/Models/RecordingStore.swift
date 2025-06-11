//
//  RecordingStore.swift
//  SessionApp
//
//  Created by macOS on 2/8/25.
//

import Foundation

// Create a data management layer
class RecordingStore: ObservableObject {
    @Published private(set) var breathingAssets: [AudioAsset] = []
    @Published private(set) var meditationAssets: [AudioAsset] = []
    
    init() {
        loadAssets()
    }
    
    private func loadAssets() {
        // Breathing exercises
        breathingAssets = [
            AudioAsset(
                title: "5-Point Check In",
                duration: 180,
                imageName: "woman_calm",
                tags: [.top, .calm],
                type: .breathing
            ),
            AudioAsset(
                title: "Sama Vritti",
                duration: 120,
                imageName: "woman_pose",
                tags: [.calm, .guided],
                type: .breathing
            ),
            AudioAsset(
                title: "Box Breathing",
                duration: 360,
                imageName: "box_breathing",
                tags: [.energize, .guided],
                type: .breathing
            )
        ]
        
        // Meditation exercises
        meditationAssets = [
            AudioAsset(
                title: "Anxiety Reduction",
                duration: 300,
                imageName: "abstract_cloud_green",
                tags: [.calm, .guided],
                type: .meditation
            ),
            AudioAsset(
                title: "Focus Meditation",
                duration: 300,
                imageName: "abstract_water",
                tags: [.calm, .guided],
                type: .meditation
            ),
            AudioAsset(
                title: "Safe Place Sensory Meditation",
                duration: 300,
                imageName: "green_blue_mood",
                tags: [.calm, .guided],
                type: .meditation
            )
        ]
    }
    
    func getAssets(type: AssetType) -> [AudioAsset] {
        switch type {
        case .breathing:
            return breathingAssets
        case .meditation:
            return meditationAssets
        case .music:
            return []  // Implement when needed
        }
    }
    
    func filteredAssets(type: AssetType, category: Category) -> [AudioAsset] {
        let assets = getAssets(type: type)
        if category == .top {
            return assets
        }
        return assets.filter { $0.tags.contains(category) }
    }
} 
