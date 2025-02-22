//
//  QueryView.swift
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
    @State private var isShowingBodySheet = false
    @State private var BodyValue = "None"
    //@State private var promptId : Int = 0
    //@State private var num:Int = 0
    //@State var answerText : String = ""
    
    @Query(filter: #Predicate<SessionEntry> {$0.sessionLabel > 0})
    var sessions:[SessionEntry]
    
    var currentSession:SessionEntry?
    var isEditing:Bool = false
    //var reflectionText:String = ""
    
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
        ZStack
        {
            Image("Star_Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
         
            VStack
            {
                /* Lets disbale the session history view for now
                if(!isEditing)
                {
                    
                    NavigationLink
                    {
                        SessionHistory(sessions:sessions)
                    }label:
                    {
                        let count = sessions.count
                        Label("Session History count: \(count)", systemImage: "quote.opening")
                    }
                    .buttonStyle(.bordered)
                    .frame(maxWidth:.infinity, alignment: .trailing)
                    .padding(.horizontal)
                }
                else
                {
                    let v = currentSession!.timestamp
                    Text(v, style:.date)
                }*/
                
                VStack {
                    Text("Dream")
                        .foregroundColor(.white)
                        .font(.openSansSemiBold(size: 35))
                        .frame(width:350, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text("Plant seeds for what is growing")
                        .foregroundColor(.white)
                        .font(.openSansSemiBold(size: 23))
                        .frame(width:350, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
                }
                
                Spacer().frame(height:10)  // Keep minimal space after title
                
                // Notebook section
                GeometryReader { geometry in
                    ScrollView {
                        VStack(spacing: 20) {
                            // Increase top padding to avoid logo overlap
                            Spacer().frame(height: 100)  // Increased from 60
                            
                            ForEach(globalCluster.promptEntries) { pBox in
                                PromptRow(pBox: pBox)
                            }
                            
                            Spacer().frame(height: 40)
                        }
                    }
                    .background(
                        Image("journal_blank_dark")  // Updated image name to match new dark version
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: geometry.size.height * 0.95)
                    )
                    .frame(width: geometry.size.width * 0.9)
                }
            }.sheet(isPresented : $isShowingBodySheet)
            {
                BodyImage(bodyvalue:self.$BodyValue)
            }
            .sheet(isPresented : $isShowingEditorSheet)
            {
                //if let uBox = selectedBox
                //{
                //addEditorSheet(boxes:$promptBoxes,
                               //promptEntry: promptBoxes.selectedEntry,
                               //currentSession: currentSession)
                
                addEditorSheet(promptEntry: globalCluster.selectedEntry,
                               currentSession: currentSession)
                
                
                //promptBoxes[selectedBox.promptID].promptAnswer = selectedBox.promptAnswer
                //}
                //else
                //{
                //    addEditorSheet(promptText: "Invalid current box", promptId: $promptId,
                //               currentSession: currentSession)
                //}
            }
        }.onAppear()
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Label("Back", systemImage: "arrow.left.circle")
                        }
                    }
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





