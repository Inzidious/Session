//
//  SessionHistory.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/28/24.
//

import SwiftUI
import SwiftData

struct SessionHistory: View {
    //var count = sessionList.count
    var sessions:[SessionEntry]
    @EnvironmentObject var globalCluster:PromptCluster
    
    var body: some View
    {
        //var f = sessions2.isEmpty
        //let _ = print("Count: \(f)")
        VStack
        {
            ForEach(sessions){ session in
                //let _ = print("looping")
                NavigationLink
                {
                    QueryView(currentSession: session, isEditing:true)
                }
                label:
                {
                    Text(session.timestamp, style:.date)
                    Text(session.sessionName)
                    Text("Count: \(session.journalEntries!.count)")
                    //Label("Session", systemImage: "quote.opening")
                    //var v = Date.now
                    //Text("hi")
                }
                Spacer().frame(height:100)
            }
        }.onAppear()
        {
            /*for session:SessionEntry in sessions
            {
                if let unwr = session.journalEntries
                {
                    //print("ENtry count: \(unwr.count)")
                    for entry:JournalEntry in unwr
                    {
                        globalCluster.promptEntries[entry.promptId].promptAnswer = entry.promptAnswer
                        globalCluster.promptEntries[entry.promptId].journalEntry = entry
                        /*if(entry.promptID >= 0 && entry.promptID < 5)
                         {
                         promptEntries[entry.promptID].promptAnswer = "hi"
                         }*/
                        
                    }
                }
            }*/
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SessionEntry.self, configurations: config)
    
    let sessions: [SessionEntry] = []
    let tempCluster = PromptCluster()
    
    return SessionHistory(sessions: sessions)
        .modelContainer(container)
        .environmentObject(tempCluster)
}
