//
//  QueryView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/6/24.
//
/*
import SwiftUI
import SwiftData
import CoreData
import Foundation

struct BackQueryView: View
{
    @Environment(\.modelContext) var context;
    
    
    @State private var pText : String = "filler"
    @State private var isShowingEditorSheet = false;
    @State private var promptId : Int = 0
    @State private var num:Int = 0
    @State var answerText : String = ""
    
    var currentSession:SessionEntry?
    var promptBoxes = [PromptEntry]()
    
    var isEditing:Bool = false
    var reflectionText:String = ""
    
    init(activeSession:SessionEntry)
    {
        currentSession = activeSession
        
        promptBoxes.append(PromptEntry(id:4, question:"Fifth prompt question"))
        promptBoxes.append(PromptEntry(id:3, question:"Fourth prompt question"))
        promptBoxes.append(PromptEntry(id:2, question:"Third prompt question"))
        promptBoxes.append(PromptEntry(id:1, question:"Second prompt question"))
        promptBoxes.append(PromptEntry(id:0, question:"First prompt question"))
    }
    
    var body: some View
    {
        ZStack
        {
            Rectangle().fill(Color("BGColor")).ignoresSafeArea()
         
            NavigationStack
            {
                VStack(spacing:30)
                {
                    Spacer().frame(height:15)
                    
                    
                    Button
                    {
                        /*let s = "New Quote: " + String(num)
                        let vv = Page2(id: UUID(), name: s)
                        vv.book = book
                        context.insert(book)
                        context.insert(vv)*/
                        
                        //try! context.save()
                        //vv.book = book
                        //book.pages?.append(vv)
                        //try! context.save()
                        
                        num += 1
                        
                        /*pText = "First prompt question"
                        promptId = 1
                        //let _ = print("first pText: " + pText + " isShowing: " + String(isShowingEditorSheet))
                        isShowingEditorSheet = true;*/
                    }
                    label:
                    {
                        //Text(book.name).font(Font.custom("Papyrus", size:25))
                        if let unwr = currentSession?.journalEntries
                        {
                            var str = "HEADER" + String(num) + "_" +
                                String(unwr.count)
                        
                            Text(str).font(Font.custom("Papyrus", size:25))
                    
                            ForEach(unwr)
                            { journalEntry in
                                @Bindable var journalItem:JournalEntry = journalEntry
                                
                                ///var str = "TEST" + String(num)
                                Text(journalItem.promptAnswer).font(Font.custom("Papyrus", size:25))
                            }
                        }
                        else
                        {
                            var str = "UNWR_FAIL"
                            
                            Text(str).font(Font.custom("Papyrus", size:25))
                        }
                        //if(currentSession.journalEntry1.promptAnswer != "")
                        //let _ = print("inside test")
                        /*if(false)//if let unwr = currentSession
                        {
                            if(false)// let unwr2 = unwr.journalEntries
                            {
                                if(false)//(unwr2.indices.contains(0))
                                {
                                    let _ = print("inside first")
                                    if(true)
                                    {
                                        boxStackViewNoTitle(
                                            bodyText: "First prompt question",
                                            boxHeight: 90,
                                            backColor: Color.white,
                                            answerText:"EMPTY")
                                        //answerText:currentSession.journalEntry1.promptAnswer)
                                        //answerText:currentSession.journalEntries[0].promptAnswer)
                                    }
                                    else
                                    {
                                        boxStackViewNoTitle(
                                            bodyText: "First prompt question",
                                            boxHeight: 90,
                                            backColor: Color.white,
                                            //answerText:currentSession.journalEntry1.promptAnswer)
                                            answerText:"NO INDICES")
                                    }
                                }
                            }
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "First prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText:"NO UNWR")
                        }*/
                    }
                    
                    Button
                    {
                        let s = "New Quote: " + String(num)
                        let vv = JournalEntry(promptId: 1, promptAnswer: "NEW ENTRY", sessionID: currentSession!.sessionID, sessionEntry: currentSession)
                        
                        //context.insert(book)
                        context.insert(vv)
                        num += 1
                        /*pText = "Second prompt question"
                        promptId = 2
                        isShowingEditorSheet = true;*/
                    }
                    label:
                    {
                        if(false)
                        //if(currentSession.journalEntry1.promptAnswer != "")
                        //if let unwr = currentSession.journalEntry1
                        //if(currentSession.journalEntries.indices.contains(1))
                        {
                            boxStackViewNoTitle(
                                bodyText: "Second prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: "Second filler")
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "Second prompt question",
                                iconName: "bicycle.circle.fill",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText:"EMPTY BLOCK")
                        }
                    }
                    
                    Button
                    {
                        pText = "Third prompt question"
                        promptId = 3
                        isShowingEditorSheet = true;
                    }
                    label:
                    {
                        if(false)//ans3.count > 0)
                        {
                            boxStackViewNoTitle(
                                bodyText: "Third prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: "EMPTY")//ans3[ans3.count - 1].promptAnswer)
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "Third prompt question",
                                iconName: "airplayvideo.circle.fill",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText:"EMPTY BLOCK")
                        }
                    }
                    
                    Button
                    {
                        promptId = 4
                        pText = "Fourth prompt question"
                        isShowingEditorSheet = true;
                    }
                    label:
                    {
                        if(false)//ans4.count > 0)
                        {
                            boxStackViewNoTitle(
                                bodyText: "Fourth prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: "EMPTY")//ans4[ans4.count - 1].promptAnswer)
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "Fourth prompt question",
                                iconName: "headphones.circle.fill",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText:"EMPTY BLOCK")
                        }
                    }
                    
                    Button
                    {
                        pText = "Fifth prompt question"
                        promptId = 5
                        isShowingEditorSheet = true;
                    }
                    label:
                    {
                        if(false)
                        {
                            boxStackViewNoTitle(
                                bodyText: "Fifth prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: "EMPTY")//ans5[ans5.count - 1].promptAnswer)
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "Fifth prompt question",
                                iconName: "building.2.crop.circle.fill",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText:"EMPTY BLOCK")
                        }
                    }
                    
                    Spacer()
                }
            }.sheet(isPresented : $isShowingEditorSheet)
            {
                addEditorSheet(promptText: $pText, promptId: $promptId,
                               currentSession: currentSession)
            }
        }
    }
}

struct addEditorSheet : View
{
    @Binding var promptText : String
    @Binding var promptId : Int
    var currentSession : SessionEntry?
    var book : Book2?
    
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
            Text(promptText).font(Font.custom("Papyrus", size:25))
            
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
                        //let _ = print("type: \(currentSession.journalEntries.self)")
                        //let _ = print("entry: \(entry)")
                        //currentSession.journalEntry1.promptAnswer = "Hi!"
                        
                        
                            let vv = Page2(id: UUID(), name: entry)
                           // book?.pages?.append(vv)
                            ///try! context.save()
                        
                            //let v2 = Page(id: UUID(), name: "Zzzzz")
                        //book?.pages?.append(vv)
                        //book?.pages?.append(v2)
                        //context.insert(vv)
                        
                        //JournalEntryTwo(promptId: promptId, promptAnswer: entry, sessionID: UUID(), sessionEntry:currentSession)
                        
                            //context.insert(vv)jiijji
                        
                            //let vv = JournalEntryTwo(promptId: promptId + 1, promptAnswer: entry, sessionID: UUID(), sessionEntry:currentSession)
                            
                            //currentSession?.journalEntries?.append(vv)
                            //context.insert(vv)
                            //context.insert(jentry)
                            
                            //try! context.save()
                            dismiss()
                        
                    }
                }
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SessionEntry.self, configurations: config)

    //let previewSession = SessionEntry(timestamp: .now, sessionLabel: 1, entries:[])
    let session = SessionEntry(timestamp: .now, sessionLabel: 1, entries: [])
    
    container.mainContext.insert(session)
    
    //QueryView(reflectionText:"").modelContainer(modelContainer)
    return QueryView(activeSession:session).modelContainer(container)
}

struct PromptEntry
{
    var isFilled:Bool = false
    var promptAnswer:String = "EMPTY_ANSWER"
    var promptQuestion:String
    var promptID:Int
    
    init(id:Int, question:String)
    {
        promptID = id
        promptQuestion = question
    }
}
*/
