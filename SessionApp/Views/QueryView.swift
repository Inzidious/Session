//
//  QueryView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/6/24.
//

import SwiftUI
import SwiftData
import CoreData
import Foundation

struct QueryView: View
{
    @Environment(\.modelContext) var context;
    @EnvironmentObject var globalCluster:PromptCluster
    @Environment(\.dismiss) var dismiss
    
    @State private var pText : String = "filler"
    @State private var isShowingEditorSheet = false;
    @State private var BodyValue = "None"
    @State private var promptId : Int = 0
    @State private var num:Int = 0
    @State var answerText : String = ""
    
    @Query(filter: #Predicate<SessionEntry> {$0.sessionLabel > 0})
    var sessions:[SessionEntry]
    
    @Query private var reminders: [Reminder]
    @State private var showCreateReminder = false
    @State private var reminderToEdit: Reminder?
    
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
        NavigationStack {
            ZStack {
                Rectangle().fill(Color("BGRev1")).ignoresSafeArea()
             
                VStack {
                    // Top Navigation Bar
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "arrow.left.circle")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Button(action: {
                            showCreateReminder = true
                        }) {
                            Image(systemName: "bell.badge")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                        .padding(.trailing)
                    }
                    .padding(.top, 20)
                    
                    // Content Area
                    TabView {
                        // Journal Tab
                        VStack {
                            Text("Generate")
                                .foregroundColor(.black)
                                .font(.openSansSemiBold(size: 35))
                                .frame(width:350, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            
                            Text("Utilize the events of your week as grist for the mill")
                                .foregroundColor(.black)
                                .font(.openSansSemiBold(size: 23))
                                .frame(width:350, alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                            
                            Spacer().frame(height:30)
                            
                            // Journal content
                            ScrollView {
                                VStack(spacing: 30) {
                                    ForEach(globalCluster.promptEntries) { pBox in
                                        Button {
                                            globalCluster.selectedEntry = pBox
                                            isShowingEditorSheet = true
                                        } label: {
                                            boxStackViewClear(
                                                bodyText: pBox.promptQuestion,
                                                answerText: pBox.promptAnswer
                                            )
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.vertical, 40)
                            }
                            .background(
                                Image("journal_blank")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 340)
                            )
                        }
                        
                        // Reminders List
                        VStack {
                            List {
                                ForEach(reminders) { reminder in
                                    ReminderRow(reminder: reminder, context: context, reminderToEdit: $reminderToEdit)
                                }
                            }
                        }
                    }
                    .tabViewStyle(.page)  // Change to page style
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                }
            }
            .navigationBarHidden(true)  // This hides the navigation bar
        }
        .sheet(isPresented: $isShowingEditorSheet) {
            NavigationStack {
                addEditorSheet(
                    promptEntry: globalCluster.selectedEntry,
                    currentSession: currentSession
                )
            }
        }
        .sheet(isPresented: $showCreateReminder) {
            CreateReminderView()
        }
        .sheet(item: $reminderToEdit) { reminder in
            UpdateReminderView(reminder: reminder)
        }
        .onAppear()
        {
            globalCluster.promptEntries[0].promptAnswer = ""
            globalCluster.promptEntries[0].journalEntry = nil
            
            globalCluster.promptEntries[1].promptAnswer = ""
            globalCluster.promptEntries[1].journalEntry = nil
            
            globalCluster.promptEntries[2].promptAnswer = ""
            globalCluster.promptEntries[2].journalEntry = nil
            
            globalCluster.promptEntries[3].promptAnswer = ""
            globalCluster.promptEntries[3].journalEntry = nil
            
            globalCluster.promptEntries[4].promptAnswer = ""
            globalCluster.promptEntries[4].journalEntry = nil
            
            if let unwr = currentSession
            {
                if let unwr2 = unwr.journalEntries
                {
                    for entry:JournalEntry in unwr2
                    {
                        globalCluster.promptEntries[entry.promptId].promptAnswer = entry.promptAnswer
                        globalCluster.promptEntries[entry.promptId].journalEntry = entry
                    }
                }
            }
            
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                print("Family: \(family) Font names: \(names)")
            }
        }
    }
}

struct QueryPreviewContainer: View {
    @StateObject private var globalCluster = PromptCluster(journalType: .generate)
    
    var body: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: SessionEntry.self, configurations: config)
        let session = SessionEntry(timestamp: .now, sessionLabel: 1, entries: [], name:"First")
        container.mainContext.insert(session)
        
        return NavigationStack {
            QueryView(currentSession: session)
                .modelContainer(container)
                .environmentObject(globalCluster)
        }
    }
}

#Preview {
    QueryPreviewContainer()
}



