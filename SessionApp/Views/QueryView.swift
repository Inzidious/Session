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
                    Text("Generate")
                        .foregroundColor(.black)
                        .font(Font.custom("Papyrus", size:30))
                        .frame(width:350, alignment: .leading)
                        .multilineTextAlignment(.leading)
                    
                    Text("Utilize the events of your week as grist for the mill")
                        .foregroundColor(.black)
                        .font(Font.custom("Papyrus", size:23))
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
                            Spacer().frame(height:10)
                            
                            
                            
                            //let _ = print(promptBoxes.promptEntries.count)
                            ForEach(globalCluster.promptEntries){ pBox in
                                //ForEach(promptBoxes.promptEntries){ pBox in
                                Button
                                {
                                    //let _ = print("Before change: " + selectedBox.promptQuestion)
                                    //selectedBox = pBox
                                    //let _ = print("After change: " + selectedBox.promptQuestion)
                                    //promptBoxes.selectedEntry = pBox
                                    globalCluster.selectedEntry = pBox
                                    isShowingEditorSheet = true;
                                }
                            label:
                                {
                                    var answered = Date()
                                    let dateFormatter = DateFormatter()
                                    let _ = dateFormatter.dateFormat = "YY/MM/dd"
                                    let dateString = "Answered: " + dateFormatter.string(from: answered)
                                    
                                    boxStackViewClear(
                                        bodyText: pBox.promptQuestion,
                                        iconName: "airplayvideo.circle.fill",
                                        boxHeight: 90,
                                        backColor: Color.white,
                                        answerText:pBox.promptAnswer)
                                }
                                
                                Spacer().frame(height:45)
                            }
                            
                            Spacer()
                        }.background()
                        {
                            Image("notebook").resizable().frame(width:340, height:600)
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
            //for session:SessionEntry in sessions
            //{
                if let unwr = currentSession
                {
                    if let unwr2 = unwr.journalEntries
                    {
                        //print("ENtry count: \(unwr2.count)")
                        for entry:JournalEntry in unwr2
                        {
                            globalCluster.promptEntries[entry.promptId].promptAnswer = entry.promptAnswer
                            globalCluster.promptEntries[entry.promptId].journalEntry = entry
                            /*if(entry.promptID >= 0 && entry.promptID < 5)
                             {
                             promptEntries[entry.promptID].promptAnswer = "hi"
                             }*/
                            
                        }
                    }
                }
            //}
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

struct addEditorSheet : View
{
    //@Binding var boxes:PromptCluster
    @EnvironmentObject var globalCluster:PromptCluster
    var promptEntry : PromptEntry
    var currentSession : SessionEntry?
    
    var rText : String = ""
    var answerText:String = ""
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    
    @State private var entry:String = ""
    @State private var data:Date = .now
    
    var body: some View
    {
        NavigationStack
        {
            Text(promptEntry.promptQuestion).font(Font.custom("Papyrus", size:25))
            
            Form
            {
                TextField("Start writing....", text:$entry, axis:.vertical )
                DatePicker("Timestamp", selection:$data, displayedComponents: .date)
                
            }
            .font(Font.custom("Papyrus", size:25))
            .toolbar
            {
                ToolbarItemGroup(placement: .topBarLeading)
                {
                    Button("Cancel"){ dismiss()}
                }
                
                ToolbarItemGroup(placement: .topBarTrailing)
                {
                    Button("Save")
                    {
                        //  If we have a journal entry associated with this prompt, we are editing
                        if let currentEntry = promptEntry.journalEntry
                        {
                            print("Inside edit")
                            currentEntry.promptAnswer = entry
                            //boxes.promptEntries[boxes.selectedEntry.promptID].promptAnswer = entry
                            globalCluster.promptEntries[globalCluster.selectedEntry.promptID].promptAnswer = entry
                            
                        }
                        else
                        {
                            print("Inside save: \(currentSession!.sessionID)")
                            // No Entry associated, so create new
                            let vv = JournalEntry(promptId: globalCluster.selectedEntry.promptID,
                                                  promptAnswer: entry,
                                                  sessionID: currentSession!.sessionID,
                                                  sessionEntry: currentSession)
                            
                            if(globalCluster.selectedEntry.promptID >= 0 && globalCluster.selectedEntry.promptID < 5)
                            {
                                globalCluster.promptEntries[globalCluster.selectedEntry.promptID].promptAnswer = entry
                            }
                            
                            //curBox.promptAnswer = entry
                            //context.insert(book)
                            
                            context.insert(vv)
                            //num += 1
                            //currentSession.journalEntry1.promptAnswer = "Hi!"
                        }
                         
                        dismiss()
                        
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing)
                {
                    Button("Edit")
                    {
                        print("Inside new save: \(currentSession!.sessionID)")
                        // No Entry associated, so create new
                        let vv = JournalEntry(promptId: globalCluster.selectedEntry.promptID,
                                              promptAnswer: entry,
                                              sessionID: currentSession!.sessionID,
                                              sessionEntry: currentSession)
                        
                        if(globalCluster.selectedEntry.promptID >= 0 && globalCluster.selectedEntry.promptID < 5)
                        {
                            globalCluster.promptEntries[globalCluster.selectedEntry.promptID].promptAnswer = entry
                        }
                        
                        //context.insert(vv)
                        
                        dismiss()
                    }
                }
            }
        }.onAppear()
        {
            //print("Here")
            
            if let e = globalCluster.selectedEntry.journalEntry
            {
                //print("Here2")
                entry = e.promptAnswer
            }
        }
    }
}

struct boxStackViewNoTitle: View
{
    var bodyText = ""
    var iconName = "tram.circle.fill"
    var boxHeight = 200.0;
    var backColor = Color.red
    var answerText = ""
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .frame(width:350, height:boxHeight)
                .foregroundColor(backColor)
                .cornerRadius(10)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x:10, y:10)
            
            HStack
            {
                Image(systemName: iconName)
                
                VStack
                {
                    Text(bodyText)
                        .foregroundColor(.black)
                        .font(Font.custom("Papyrus", size:20))
                        .padding(10)
                        .frame(width:250, alignment: .bottomLeading)
                        .multilineTextAlignment(.leading)
                    
                    Text(answerText)
                }
                
                Image(systemName: "arrow.right")
            }
            
        }.frame(maxWidth:.infinity, alignment: .center)
    }
}

struct boxStackViewClear: View
{
    var bodyText = ""
    var iconName = "tram.circle.fill"
    var boxHeight = 200.0;
    var backColor = Color.red
    var answerText = ""
    
    var body: some View
    {
        VStack
        {
            ZStack
            {
                Rectangle()
                    .frame(width:250, height:40)
                    .foregroundColor(Color.gray)
                    .cornerRadius(10)
                    .opacity(0.4)
                
                Text(bodyText)
                    .foregroundColor(.black)
                    .font(Font.custom("Papyrus", size:20))
                    .padding(10)
                    .frame(width:250, alignment: .bottomLeading)
                    .multilineTextAlignment(.leading)
            }
            Text(answerText)
        }
    }
}


extension View {
    func PPrint(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

private func lastLocationPosition() -> Int? {
    var fetchDescriptor = FetchDescriptor<SessionEntry>()
    fetchDescriptor.propertiesToFetch = [\.sessionID]  // only the positions values come back fully realized
    do {
        //var locations = nil? //try fetch<SessionEntry>(fetchDescriptor)
        return nil //locations.map({ $0.sessionID }).max()
    } catch let error {
        print("*** cannot fetch locations: \(error.localizedDescription)")
        return nil
    }
}

#Preview 
{
    //var tsession = SessionEntry(timestamp: .now, sessionLabel: 1, entries: [])
    //@StateObject var globalCluster = PromptCluster(session:tsession, edit:false)
    
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SessionEntry.self, configurations: config)
    let twodays = Date.now.addingTimeInterval(-2*(24 * 60 * 60))
    let threedays = Date.now.addingTimeInterval(-3*(24 * 60 * 60))
    
    //let previewSession = SessionEntry(timestamp: .now, sessionLabel: 1, entries:[])
    var session = SessionEntry(timestamp: .now, sessionLabel: 1, entries: [], name:"First")
    container.mainContext.insert(session)
    
    session = SessionEntry(timestamp: twodays, sessionLabel: 2, entries: [], name:"Second")
    container.mainContext.insert(session)
    
    session = SessionEntry(timestamp: threedays, sessionLabel: 3, entries: [], name:"Third")
    container.mainContext.insert(session)
    
    @StateObject var globalCluster = PromptCluster()
    
    //QueryView(reflectionText:"").modelContainer(modelContainer)
    return NavigationStack
    {
        return QueryView(currentSession:session).modelContainer(container)
    }.environmentObject(globalCluster)
}

class PromptCluster : ObservableObject
{
    var promptEntries = [PromptEntry]()
    var selectedEntry:PromptEntry
    
    init()
    {
        //print("Editing: \(edit)")
        promptEntries.append(PromptEntry(id:0, question:"First prompt question"))
        promptEntries.append(PromptEntry(id:1, question:"Second prompt question"))
        promptEntries.append(PromptEntry(id:2, question:"Third prompt question"))
        promptEntries.append(PromptEntry(id:3, question:"Fourth prompt question"))
        promptEntries.append(PromptEntry(id:4, question:"Fifth prompt question"))
        
        selectedEntry = promptEntries[0]
        
        /*if(edit)
        {
            if let unwr = session.journalEntries
            {
                for entry:JournalEntry in unwr
                {
                    promptEntries[entry.promptId].promptAnswer = entry.promptAnswer
                    promptEntries[entry.promptId].journalEntry = entry
                    /*if(entry.promptID >= 0 && entry.promptID < 5)
                    {
                        promptEntries[entry.promptID].promptAnswer = "hi"
                    }*/
                   
                }
            }
        }*/
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
