//
//  FeelingEntry.swift
//  SessionApp
//
//  Created by macOS on 2/14/25.
//


import Foundation
import SwiftData



@Model
final class FeelingEntry {
    var feelingID: UUID
    var name: String
    var sleep: Int
    var food: Int
    var move: Int
    var irrit: Int
    var cycle: Int
    var medi: Int
    var feeling: Int
    var triggers: String
    var timestamp: Date
    var user: User
    
    init(nameTxt: String, user:User) {
        self.sleep = 0
        self.food = 0
        self.move = 0
        self.irrit = 0
        self.triggers = ""
        self.cycle = 0
        self.medi = 0
        self.feeling = 0
        self.name = nameTxt
        self.feelingID = UUID()
        self.timestamp = .now
        self.user = user
    }
}
