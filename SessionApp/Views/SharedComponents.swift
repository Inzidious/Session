import SwiftUI
import SwiftData

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
            Text(promptEntry.promptQuestion).font(Font.custom("OpenSans-Regular", size:25))
            
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
            if let e = globalCluster.selectedEntry.journalEntry
            {
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
        VStack(spacing: 8) {
            ZStack {
                Rectangle()
                    .frame(width: 220, height: 40)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Text(bodyText)
                    .foregroundColor(.black)
                    .font(Font.custom("OpenSans-Regular", size: 16))
                    .padding(8)
                    .frame(width: 200, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            
            if !answerText.isEmpty {
                Text(answerText)
                    .font(Font.custom("OpenSans-Regular", size: 14))
                    .foregroundColor(.gray)
                    .frame(width: 200, alignment: .leading)
            }
        }
        .padding(.horizontal)
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
    fetchDescriptor.propertiesToFetch = [\SessionEntry.sessionID]
    do {
        return nil //locations.map({ $0.sessionID }).max()
    } catch let error {
        print("*** cannot fetch locations: \(error.localizedDescription)")
        return nil
    }
}
