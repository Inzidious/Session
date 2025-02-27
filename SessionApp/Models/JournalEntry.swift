//
//  JournalEntry.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/11/24.
//

import Foundation
import SwiftData

@Model
final class JournalEntry
{
    var sessionId:UUID
    var promptId:Int
    var promptAnswer:String
    var sessionEntry:SessionEntry?
    var timestamp: Date
    
    @Relationship(inverse: \User.journalEntries) var user: User?
    
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
