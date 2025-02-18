//
//  SessionEntry.swift
//  SessionApp
//
//  Created by macOS on 2/14/25.
//


import Foundation
import SwiftData
//import User

@Model
final class SessionEntry {
    var sessionID: UUID
    var sessionLabel: Int
    var timestamp: Date
    var sessionName: String
    
    @Relationship
    var user: User?
    
    @Relationship(deleteRule: .cascade, inverse: \JournalEntry.sessionEntry)
    var journalEntries: [JournalEntry]?
    
    init(timestamp: Date, sessionLabel: Int, entries: [JournalEntry], name: String = "") {
        self.sessionName = name
        self.sessionID = UUID()
        self.timestamp = timestamp
        self.sessionLabel = sessionLabel
        self.journalEntries = entries
        self.user = nil as User?
    }
}
