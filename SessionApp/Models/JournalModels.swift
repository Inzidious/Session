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
    var selectedEntry: PromptEntry
    
    init(journalType: JournalType = .dream) {
        let questions = Self.getQuestions(for: journalType)
        
        promptEntries = questions.enumerated().map { index, question in
            PromptEntry(id: index, question: question)
        }
        
        selectedEntry = promptEntries[0]
    }
    
    enum JournalType {
        case dream
        case generate
        case expand // Add your third journal type here
    }
    
    private static func getQuestions(for type: JournalType) -> [String] {
        switch type {
        case .dream:
            return [
                "What was the story fo your dream?",
                "Emotions present in your dream?",
                "Sensations in my body upon waking?",
                "Who were the characters? Do you know them? if not woh do they remind you of? ",
                "Any symbols, colors, shapes or elements?"
            ]
        case .generate:
            return [
                "What affeccted me today?",
                "Emotions I was feeling were?",
                "Senssations in my body?",
                "My thoughts were saying...",
                "This reminds me of..."
            ]
        case .expand:
            return [
                "Topics we covered today were...",
                "Emotions I was feeling were...",
                "Sensations in my body were...",
                "Dots we connected were...",
                "This coming week I want to remember..."
            ]
        }
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
