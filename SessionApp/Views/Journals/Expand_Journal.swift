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
    @StateObject private var globalCluster = PromptCluster(journalType: .expand)
    @Environment(\.dismiss) var dismiss
    
    @State private var pText : String = "filler"
    @State private var isShowingEditorSheet = false;
    @State private var isShowingBodySheet = false
    @State private var isShowingReminderSheet = false
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
                // Custom back arrow (dismiss)
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left.circle")
                        .font(.title2)
                        .foregroundColor(Color(red: 0.882, green: 0.694, blue: 0.416))
                        .scaleEffect(1.25)
                }
                .padding(.leading, 10)
                Spacer()
                // Profile icon (navigate to ProfileView)
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
                .padding(.trailing, 10)
            }
            .padding(.top, 50)
            .padding(.bottom, 10)
            .background(
                Color(red: 250/255, green: 249/255, blue: 246/255)
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
        .onDisappear {
            // Reset to default tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 250/255, green: 249/255, blue: 246/255, alpha: 1) // #faf9f6
            appearance.stackedLayoutAppearance.selected.iconColor = .black
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.stackedLayoutAppearance.normal.iconColor = .black
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct ExpandPreviewContainer: View {
    @StateObject private var globalCluster = PromptCluster(journalType: .expand)
    
    var body: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: SessionEntry.self, configurations: config)
        let session = SessionEntry(timestamp: .now, sessionLabel: 1, name:"First", user:GlobalUser.shared.user)
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




