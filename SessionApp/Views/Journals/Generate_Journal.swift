//
//  Generate_Journal.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/6/24.
//

import SwiftUI
import SwiftData
import CoreData
import Foundation

struct Generate_Journal: View
{
    @Environment(\.modelContext) var context;
    @EnvironmentObject var globalCluster:PromptCluster
    @Environment(\.dismiss) var dismiss
    
    @State private var pText : String = "filler"
    @State private var isShowingEditorSheet = false;
    @State private var isShowingReminderSheet = false;
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
                    
                    // Content Area
                    TabView {
                        // Journal Tab
                        VStack(spacing: 1) {
                            
                            Text("Generate")
                                .foregroundColor(.black)
                                .font(.openSansSemiBold(size: 35))
                                .frame(width:350, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            
                            Text("Utilize the events of your week as grist for the mill")
                                .foregroundColor(.black)
                                .font(.openSansSemiBold(size: 22))
                                .frame(width:350, alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                            
                            //Spacer().frame(height:1)
                            
                            // Journal content
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
                                    .padding(.vertical, 25)
                                }
                            }
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
            .navigationBarHidden(true)
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
        .sheet(isPresented: $isShowingEditorSheet) {
            NavigationStack {
                addEditorSheet(
                    promptEntry: globalCluster.selectedEntry,
                    currentSession: currentSession
                )
            }
        }
        .sheet(isPresented: $isShowingReminderSheet) {
            NavigationStack {
                CreateReminderView()
            }
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
    @Environment(\.modelContext) var context;
    
    var session:SessionEntry
    
    var body: some View {
    
        return NavigationStack {
            Generate_Journal(currentSession: session).environmentObject(globalCluster)
                
        }
    }
}

#Preview {
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SessionEntry.self, Reminder.self, User.self, configurations: config)
    
    var _ = GlobalUser.shared.setContext(context:container.mainContext)
    
    let session = SessionEntry(timestamp: .now, sessionLabel: 1, name:"New Session", user:GlobalUser.shared.user)
    
    QueryPreviewContainer(session:session).modelContainer(container)
}





