//
//  JournalEntry.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/11/24.
//

import Foundation
import SwiftData

@Model
final class JournalEntry : Codable
{
    var sessionId:UUID
    var promptId:Int
    var promptAnswer:String
    var sessionEntry:SessionEntry?
    var timestamp: Date
    
    @Relationship(inverse: \User.journalEntries) var user: User?
    
    enum CodingKeys: CodingKey {
        case promptId, promptAnswer, sessionEntry, timestamp, sessionId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sessionId = UUID()
        self.promptId = try container.decode(Int.self, forKey: .promptId)
        self.promptAnswer = try container.decode(String.self, forKey: .promptAnswer)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(sessionId, forKey: .sessionId)
        try container.encode(promptId, forKey: .promptId)
        try container.encode(promptAnswer, forKey: .promptAnswer)
        try container.encode(timestamp, forKey: .timestamp)
    }
    
    init(promptId: Int, promptAnswer: String, sessionID:UUID, sessionEntry:SessionEntry?)
    {
        self.promptId = promptId
        self.promptAnswer = promptAnswer
        self.sessionId = sessionID
        self.sessionEntry = sessionEntry
        self.user = nil
        self.timestamp = .now
    }
}
