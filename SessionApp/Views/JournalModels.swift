//
//  JournalModels.swift
//  SessionApp
//
//  Created by Ahmed on 2/3/25.
//
import SwiftUI

class PromptCluster : ObservableObject
{
    var promptEntries = [PromptEntry]()
    var selectedEntry:PromptEntry
    
    init()
    {
        //print("Editing: \(edit)")
        promptEntries.append(PromptEntry(id:0, question:"First prompt question"))
        promptEntries.append(PromptEntry(id:1, question:"Second prompt question"))
        promptEntries.append(PromptEntry(id:2, question:"Third prompt question"))
        promptEntries.append(PromptEntry(id:3, question:"Fourth prompt question"))
        promptEntries.append(PromptEntry(id:4, question:"Fifth prompt question"))
        
        selectedEntry = promptEntries[0]
        
        /*if(edit)
        {
            if let unwr = session.journalEntries
            {
                for entry:JournalEntry in unwr
                {
                    promptEntries[entry.promptId].promptAnswer = entry.promptAnswer
                    promptEntries[entry.promptId].journalEntry = entry
                    /*if(entry.promptID >= 0 && entry.promptID < 5)
                    {
                        promptEntries[entry.promptID].promptAnswer = "hi"
                    }*/
                   
                }
            }
        }*/
    }
}

struct PromptEntry : Identifiable
{
    let id:UUID = UUID()
    var isFilled:Bool = false
    var promptAnswer:String = "EMPTY_ANSWER"
    var promptQuestion:String
    var promptID:Int
    var journalEntry:JournalEntry?
    
    init(id:Int, question:String)
    {
        promptID = id
        promptQuestion = question
    }
}
