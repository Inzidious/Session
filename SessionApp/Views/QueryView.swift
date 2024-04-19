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
    @Query(filter: #Predicate<JournalEntryTwo> { $0.promptId == 1 }) var ans1:[JournalEntryTwo]
    @Query(filter: #Predicate<JournalEntryTwo> { $0.promptId == 2 }) var ans2:[JournalEntryTwo]
    @Query(filter: #Predicate<JournalEntryTwo> { $0.promptId == 3 }) var ans3:[JournalEntryTwo]
    @Query(filter: #Predicate<JournalEntryTwo> { $0.promptId == 4 }) var ans4:[JournalEntryTwo]
    @Query(filter: #Predicate<JournalEntryTwo> { $0.promptId == 5 }) var ans5:[JournalEntryTwo]
    
    @Environment(\.modelContext) var context;
    
    
    @State private var pText : String = "filler"
    @State private var isShowingEditorSheet = false;
    @State private var promptId : Int = 0
    @State var answerText : String = ""
    
    var reflectionText:String
    
    init(reflectionText:String)
    {
        self.reflectionText = reflectionText
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
                        pText = "First prompt question"
                        promptId = 1
                        let _ = print("first pText: " + pText + " isShowing: " + String(isShowingEditorSheet))
                        isShowingEditorSheet = true;
                    }
                    label:
                    {
                        if(ans1.count > 0)
                        {
                            boxStackViewNoTitle(
                                bodyText: "First prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: ans1[ans1.count - 1].promptAnswer)
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "First prompt question",
                                boxHeight: 90,
                                backColor: Color.white)
                        }
                    }
                    
                    Button
                    {
                        pText = "Second prompt question"
                        promptId = 2
                        isShowingEditorSheet = true;
                    }
                    label:
                    {
                        if(ans2.count > 0)
                        {
                            boxStackViewNoTitle(
                                bodyText: "Second prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: ans2[ans2.count - 1].promptAnswer)
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "Second prompt question",
                                iconName: "bicycle.circle.fill",
                                boxHeight: 90,
                                backColor: Color.white)
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
                        if(ans3.count > 0)
                        {
                            boxStackViewNoTitle(
                                bodyText: "Third prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: ans3[ans3.count - 1].promptAnswer)
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "Third prompt question",
                                iconName: "airplayvideo.circle.fill",
                                boxHeight: 90,
                                backColor: Color.white)
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
                        if(ans4.count > 0)
                        {
                            boxStackViewNoTitle(
                                bodyText: "Fourth prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: ans4[ans4.count - 1].promptAnswer)
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "Fourth prompt question",
                                iconName: "headphones.circle.fill",
                                boxHeight: 90,
                                backColor: Color.white)
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
                        if(ans5.count > 0)
                        {
                            boxStackViewNoTitle(
                                bodyText: "Fifth prompt question",
                                boxHeight: 90,
                                backColor: Color.white,
                                answerText: ans5[ans5.count - 1].promptAnswer)
                        }
                        else
                        {
                            boxStackViewNoTitle(
                                bodyText: "Fifth prompt question",
                                iconName: "building.2.crop.circle.fill",
                                boxHeight: 90,
                                backColor: Color.white)
                        }
                    }
                    
                    Spacer()
                }
            }.sheet(isPresented : $isShowingEditorSheet)
            {
                addEditorSheet(promptText: $pText, promptId: $promptId, rText:reflectionText)
            }
        }
    }
}

struct addEditorSheet : View
{
    @Binding var promptText : String
    @Binding var promptId : Int
    
    var rText : String
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
                        let jentry = JournalEntryTwo(promptId: promptId, promptAnswer: entry, sessionID: 1)
                        
                        context.insert(jentry)
                        
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

#Preview {
    QueryView(reflectionText:"").modelContainer(for:JournalEntryTwo.self)
}
