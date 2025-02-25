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
        VStack(spacing: 0) { // Zero spacing to control layout precisely
            // Top Navigation Bar
            HStack {
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.circle.fill")
                        .scaleEffect(1.9)
                        .font(.title2)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color(red: 225/255, green: 178/255, blue: 107/255),
                            Color(red: 249/255, green: 240/255, blue: 276/255)
                        )
                }
                .padding(.leading, 20)
                Spacer()
                
                NavigationLink(destination: CreateReminderView()) {
                    Image(systemName: "bell.badge.fill")
                        .scaleEffect(1.3)
                        .font(.title2)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color(red: 249/255, green: 240/255, blue: 276/255),
                            Color(red: 225/255, green: 178/255, blue: 107/255)
                        )
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            .padding(.trailing,10)
            .background(
                Color(#colorLiteral(red: 0.9803921569, green: 0.9764705882, blue: 0.9647058824, alpha: 1))
                    .opacity(0.2)
                    .ignoresSafeArea(edges: .top)
            )
            
            // Title and Subtitle
            Text("Expand")
                .foregroundColor(.black)
                .font(.openSansSemiBold(size: 35))
                .frame(width: 350, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            Text("Deepen your understanding through reflection")
                .foregroundColor(.black)
                .font(.openSansSemiBold(size: 22))
                .frame(width: 350, alignment: .trailing)
                .multilineTextAlignment(.trailing)
            
            // Journal content with notebook background
            ZStack(alignment: .top) {
                Image("journal_blank")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 330)
                    .offset(y: 10)
                
                ScrollView {
                    VStack(spacing: 25) {
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
                    .padding(.vertical, 15)
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowingEditorSheet) {
            NavigationStack {
                addEditorSheet(
                    promptEntry: globalCluster.selectedEntry,
                    currentSession: currentSession
                )
            }
        }
        .onAppear {
            // Keep your existing onAppear logic
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




