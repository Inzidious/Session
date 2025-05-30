//
//  Journal_Dream.swift
//  SessionApp
//
//  Updates 2/6/2025 - Update UI/UX desing
//

import SwiftUI
import SwiftData
import CoreData
import Foundation

struct JournalDreamView: View
{
    @Environment(\.modelContext) var context;
    @EnvironmentObject var globalCluster:PromptCluster
    @Environment(\.dismiss) var dismiss
    
    // Unused variables - kept for future features
    //@State private var pText : String = "filler"
    @State private var isShowingEditorSheet = false;
    @State private var isShowingReminderSheet = false;
    @State private var isShowingBodySheet = false
    @State private var BodyValue = "None"
    //@State private var promptId : Int = 0
    //@State private var num:Int = 0
    //@State var answerText : String = ""
    
    @Query(filter: #Predicate<SessionEntry> {$0.sessionLabel > 0})
    var sessions:[SessionEntry]
    
    var currentSession: SessionEntry?
    var isEditing: Bool = false
    //var reflectionText:String = ""
    
    init(currentSession: SessionEntry? = nil, isEditing: Bool = false) {
        // Configure TabBar appearance specifically for this view
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 47/255, green: 49/255, blue: 49/255, alpha: 1) // #2f3131
        
        // Set the selected and unselected item colors
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    /*init(activeSession:SessionEntry, editing:Bool = false)
    {
        //currentSession = activeSession
        isEditing = editing
        
        promptBoxes = PromptCluster(session:activeSession, edit:editing)
        //newCluster = PromptCluster(session:activeSession, edit:editing)
    }*/
    
    // Extract the prompt row into a separate view
    private func PromptRow(pBox: PromptEntry) -> some View {
        HStack {
            //Button {
            //    globalCluster.selectedEntry = pBox
            //    isShowingEditorSheet = true
            //} label: {
            //    boxStackViewClear(
            //        bodyText: pBox.promptQuestion,
            //        iconName: "airplayvideo.circle.fill",
            //        boxHeight: 70,
            //        //backColor: Color.clear,
            //        answerText: pBox.promptAnswer)
           // }
            //.frame(maxWidth: .infinity)
            
            // Updated condition to match other journals and include both emotions and sensations
            if pBox.promptQuestion.lowercased().contains("emotions") ||
               pBox.promptQuestion.lowercased().contains("sensations") {
                HStack(spacing: 8) {
                    NavigationLink(destination: 
                        FeelingsWheelContainerView(onFeelingSelected: { feeling in
                            if let index = globalCluster.promptEntries.firstIndex(where: { $0.id == pBox.id }) {
                                globalCluster.promptEntries[index].promptAnswer = feeling
                            }
                            dismiss()
                        })
                    ) {
                        Image("feelings_wheel_icon")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)  // Changed to white for dark theme
                    }
                    
                    Button {
                        isShowingBodySheet = true
                    } label: {
                        Image("body_picker")
                            .resizable()
                            .frame(width: 25, height: 35)
                            .foregroundColor(.white)  // Changed to white for dark theme
                    }
                }
                .padding(.leading, 8)
            }
        }
        .padding(.horizontal, 20)
    }
    
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
                            Color.white
                        )
                }
                .padding(.trailing, 10)
            }
            .padding(.top, 50)
            .padding(.bottom, 10)
            .background(
                Color.black.opacity(0.2)
                    .ignoresSafeArea(edges: .top)
            )
            
            // Title and Subtitle
            Text("Dream")
                .foregroundColor(.white)
                .font(.openSansSemiBold(size: 35))
                .frame(width: 350, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            Text("Plant seeds for what is growing")
                .foregroundColor(.white)
                .font(.openSansSemiBold(size: 22))
                .frame(width: 350, alignment: .trailing)
                .multilineTextAlignment(.trailing)
            
            // Journal content with notebook background
            ZStack(alignment: .top) {
                Image("journal_blank_dark")  // Using dark theme notebook
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
        .background(
            ZStack {
                Image("Star_Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                // Dark overlay for the bottom area
                Rectangle()
                    .fill(Color(red: 47/255, green: 49/255, blue: 49/255))
                    .frame(height: 83) // Standard TabView height
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .edgesIgnoringSafeArea(.bottom)
            }
        )
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(false)
        .sheet(isPresented: $isShowingEditorSheet) {
            NavigationStack {
                addEditorSheet(
                    promptEntry: globalCluster.selectedEntry,
                    currentSession: currentSession
                )
            }
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

struct DreamPreviewContainer: View {
    @StateObject private var globalCluster = PromptCluster(journalType: .dream)
    
    var body: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        if let container = try? ModelContainer(for: SessionEntry.self, configurations: config) {
            NavigationStack {
                JournalDreamView(currentSession: nil)
                    .modelContainer(container)
                    .environmentObject(globalCluster)
            }
        } else {
            Text("Failed to create preview container")
        }
    }
}

#Preview {
    DreamPreviewContainer()
}





