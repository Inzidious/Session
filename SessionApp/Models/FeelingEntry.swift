//
//  FeelingEntry.swift
//  SessionApp
//
//  Created by macOS on 2/14/25.
//


import Foundation
import SwiftData

@Model
final class FeelingEntry : Codable {
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
    var user: User?
    
    enum CodingKeys: CodingKey {
        case name,feelingID,sleep,food,move,irrit,cycle,medi,feeling,triggers,timestamp
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.sleep = try container.decode(Int.self, forKey: .sleep)
        self.food = try container.decode(Int.self, forKey: .food)
        self.move = try container.decode(Int.self, forKey: .move)
        self.irrit = try container.decode(Int.self, forKey: .irrit)
        self.triggers = try container.decode(String.self, forKey: .triggers)
        self.cycle = try container.decode(Int.self, forKey: .cycle)
        self.medi = try container.decode(Int.self, forKey: .medi)
        self.feeling = try container.decode(Int.self, forKey: .feeling)
        self.feelingID = UUID()
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(sleep, forKey: .sleep)
        try container.encode(food, forKey: .food)
        try container.encode(move, forKey: .move)
        try container.encode(irrit, forKey: .irrit)
        try container.encode(triggers, forKey: .triggers)
        try container.encode(cycle, forKey: .cycle)
        try container.encode(medi, forKey: .medi)
        try container.encode(feeling, forKey: .feeling)
        try container.encode(feelingID, forKey: .feelingID)
        try container.encode(timestamp, forKey: .timestamp)
    }
    
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
