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
    var sessionId:Int
    var promptId:Int
    var promptAnswer:String
    
    init(promptId: Int, promptAnswer: String, sessionID:Int)
    {
        self.promptId = promptId
        self.promptAnswer = promptAnswer
        self.sessionId = sessionID
    }
}

@Model
class JournalEntryTwo
{
    var sessionId:Int
    var promptId:Int
    var promptAnswer:String
    
    init(promptId: Int, promptAnswer: String, sessionID:Int)
    {
        self.promptId = promptId
        self.promptAnswer = promptAnswer
        self.sessionId = sessionID
    }
}

@Model
class SessionEntry
{
    var sessionID:Int
    var sessionIdentifier:Int
    var timestamp:Date
    
    init(sessionID:Int, timestamp:Date, identifier:Int)
    {
        self.sessionID = sessionID
        self.timestamp = timestamp
        self.sessionIdentifier = identifier
    }
}
