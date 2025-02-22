//
//  Expand_Journal.swift
//  SessionApp
//
//  Created by macOS on 2/8/25.
//

import SwiftUI
import SwiftData
import CoreData
import Foundation

struct Expand_Journal: View
{
    @Environment(\.modelContext) var context;
    @EnvironmentObject var globalCluster:PromptCluster
    @Environment(\.dismiss) var dismiss
    
    @State private var pText : String = "filler"
    @State private var isShowingEditorSheet = false;
    @State private var isShowingBodySheet = false
    @State private var BodyValue = "None"
    @State private var promptId : Int = 0
    @State private var num:Int = 0
    @State var answerText : String = ""
    
    @Query(filter: #Predicate<SessionEntry> {$0.sessionLabel > 0})
    var sessions:[SessionEntry]
    
    var currentSession:SessionEntry?
    
    var isEditing:Bool = false
    var reflectionText:String = ""
    
    /*init(activeSession:SessionEntry, editing:Bool = false)
    {
        //currentSession = activeSession
        isEditing = editing
        
        promptBoxes = PromptCluster(session:activeSession, edit:editing)
        //newCluster = PromptCluster(session:activeSession, edit:editing)
    }*/
    
    var body: some View
    {
        // Temporarily simplify the view for preview purposes
        Text("Expand Journal - Under Construction")
            .onAppear {
                // Keep the onAppear logic if needed for data
                if let unwr = currentSession {
                    if let unwr2 = unwr.journalEntries {
                        for entry: JournalEntry in unwr2 {
                            globalCluster.promptEntries[entry.promptId].promptAnswer = entry.promptAnswer
                            globalCluster.promptEntries[entry.promptId].journalEntry = entry
                        }
                    }
                }
            }
    }
}

struct ExpandPreviewContainer: View {
    @StateObject private var globalCluster = PromptCluster(journalType: .expand)
    
    var body: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: SessionEntry.self, configurations: config)
        let session = SessionEntry(timestamp: .now, sessionLabel: 1, entries: [], name:"First")
        container.mainContext.insert(session)
        
        return NavigationStack {
            Expand_Journal(currentSession: session)
                .modelContainer(container)
                .environmentObject(globalCluster)
        }
    }
}

#Preview {
    ExpandPreviewContainer()
}




