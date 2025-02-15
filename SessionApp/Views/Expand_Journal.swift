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
        ZStack
        {
            Rectangle().fill(Color("BGRev1")).ignoresSafeArea()
         
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
                
                VStack
                {
                    Text("Expand")
                        .foregroundColor(.black)
                        .font(.openSansSemiBold(size: 35))
                        .frame(width:350, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text("Mine your most powerful insights from session")
                        .foregroundColor(.black)
                        .font(.openSansSemiBold(size: 23))
                        .frame(width:350, alignment: .trailing)
                        .multilineTextAlignment(.trailing)
                }
                
                Spacer().frame(height:30)
                
                HStack
                {
                    HStack
                    {
                        Spacer().frame(width:50)
                        ScrollView()
                        {
                            // Reduce the spacing after logo
                            Image("journal_blank")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 340)
                                .opacity(0.0)  // Make invisible but preserve space
                                .frame(height: 80)  // Reduced from 150 to 80
                            
                            ForEach(globalCluster.promptEntries) { pBox in
                                HStack {
                                    Button {
                                        globalCluster.selectedEntry = pBox
                                        isShowingEditorSheet = true
                                    } label: {
                                        boxStackViewClear(
                                            bodyText: pBox.promptQuestion,
                                            iconName: "airplayvideo.circle.fill",
                                            boxHeight: 70,
                                            backColor: Color.white,
                                            answerText: pBox.promptAnswer)
                                    }
                                    
                                    // Add feelings wheel icon for emotion-related prompts
                                    if pBox.promptQuestion.lowercased().contains("emotions") ||
                                       pBox.promptQuestion.lowercased().contains("feeling") {
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
                                                .foregroundColor(.black)
                                        }
                                        .padding(.leading, 8)
                                    }
                                }
                                
                                Spacer().frame(height: 25)
                            }
                            
                            Spacer()
                        }.background()
                        {
                            Image("journal_blank").resizable().scaledToFit().frame(width:340)
                        }
                    }
                    
                    Button()
                    {
                        isShowingBodySheet = true
                    }
                    label:
                    {
                        VStack
                        {
                            Image("body_picker").resizable().frame(width:37, height:50)
                            Text("\(self.BodyValue)")
                        }.offset(x:-15)
                    }
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




