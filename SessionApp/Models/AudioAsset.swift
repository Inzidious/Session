//
//  AudioAsset.swift
//  SessionApp
//

import Foundation

// Asset Types
enum AssetType {
    case breathing
    case meditation
    case music
}

// Categories for filtering
enum Category: String, CaseIterable {
    case top = "Top"
    case calm = "Calm"
    case energize = "Energize"
    case guided = "Guided"
    case animations = "Animations"
}

// Main asset model
struct AudioAsset: Identifiable {
    let id = UUID()
    let title: String
    let duration: TimeInterval
    let imageName: String
    let audioFileName: String
    let tags: Set<Category>
    let type: AssetType
} 
