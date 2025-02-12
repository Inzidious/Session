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
                title: "3 Minutes to Calm",
                duration: 180,
                imageName: "woman_calm",
                audioFileName: "s_audio",
                tags: [.top, .calm],
                type: .breathing
            ),
            AudioAsset(
                title: "Sama Vritti-Even Breath",
                duration: 120,
                imageName: "woman_pose",
                audioFileName: "even_breath",
                tags: [.calm, .guided],
                type: .breathing
            ),
            AudioAsset(
                title: "Box Breathing",
                duration: 360,
                imageName: "box_breathing",
                audioFileName: "box_breathing",
                tags: [.energize, .guided],
                type: .breathing
            ),
            AudioAsset(
                title: "Alternate Nostril",
                duration: 300 ,
                imageName: "medi_sphere",
                audioFileName: "alternate_nostril",
                tags: [.calm, .guided],
                type: .breathing
            )
        ]
        
        // Meditation exercises
        meditationAssets = [
            AudioAsset(
                title: "Anxiety Reduction",
                duration: 300,
                imageName: "abstract_cloud_green",
                audioFileName: "Anxiety_Reduction",
                tags: [.calm, .guided],
                type: .meditation
            ),
            AudioAsset(
                title: "Focus Meditation",
                duration: 300,
                imageName: "abstract_water",
                audioFileName: "Focus_Meditation",
                tags: [.calm, .guided],
                type: .meditation
            ),
            AudioAsset(
                title: "Safety Sensory Meditation",
                duration: 300,
                imageName: "green_blue_mood",
                audioFileName: "SafePlaceSensoryMeditation",
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
