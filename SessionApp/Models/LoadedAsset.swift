//
//  LoadedAsset.swift
//  SessionApp
//
//  Created by Shawn McLean on 2/28/25.
//

import Foundation

struct LoadedAsset: Codable, Identifiable {
    let id:Int
    let title: String    // This will be used as the name parameter
    let thumbnail: String
    let size: Int
    let author:String
    let url: String
}
