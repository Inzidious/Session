//
//  JournalEntry.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/11/24.
//

import Foundation
import SwiftData

@Model
class JournalEntry
{
    var sessionId:UUID
    var promptId:Int
    var promptAnswer:String
    var sessionEntry:SessionEntry?
    
    init(promptId: Int, promptAnswer: String, sessionID:UUID, sessionEntry:SessionEntry?)
    {
        self.promptId = promptId
        self.promptAnswer = promptAnswer
        self.sessionId = sessionID
        self.sessionEntry = sessionEntry
    }
}

@Model
class Page2
{
    var id:UUID
    var name:String
    
    //@Relationship(deleteRule: .cascade, inverse: \JournalEntryTwo.sessionEntry)
    var book:Book2?
    
    init(id:UUID, name:String)
    {
        self.id = id
        self.name = name
    }
}

@Model
class Book2
{
    var id:UUID
    var name:String
    
    @Relationship(deleteRule: .cascade, inverse: \Page2.book)
    var pages:[Page2]?
    
    init(id:UUID, name:String)
    {
        self.id = id
        self.name = name
    }
}

@Model
class SessionEntry : Identifiable
{
    var sessionID:UUID
    var sessionLabel:Int
    var timestamp:Date
    var sessionName:String
    
    @Relationship(deleteRule: .cascade, inverse: \JournalEntry.sessionEntry)
    var journalEntries:[JournalEntry]?
    
    init(timestamp:Date, sessionLabel:Int, entries:[JournalEntry], name:String = "")
    {
        self.sessionName = name
        self.sessionID = UUID()
        self.timestamp = timestamp
        self.sessionLabel = sessionLabel
        self.journalEntries = entries
        
        ///journalEntry1 = JournalEntryTwo(promptId: 1, promptAnswer: "Filler", sessionID: 1)
    }
}
