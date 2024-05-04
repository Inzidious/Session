//
//  JournalView.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/22/24.
//

import SwiftUI
import SwiftData

struct JournalView: View 
{
    @StateObject var globalCluster = PromptCluster()
    @Environment(\.modelContext) var context;
    var newSession:SessionEntry
    var newSession2:SessionEntry
    var newSession3:SessionEntry
    
    init()
    {
        newSession = SessionEntry(timestamp: .now, sessionLabel: 1, entries: [], name:"First")
        newSession2 = SessionEntry(timestamp: .now, sessionLabel: 1, entries: [], name:"Second")
        newSession3 = SessionEntry(timestamp: .now, sessionLabel: 1, entries: [], name:"Third")
    }
    
    var body: some View
    {
        ZStack
        {
            Rectangle().fill(Color("BGColor"))
            NavigationStack
            {
                VStack
                {
                    //  Spacing rectangle
                    //Rectangle()
                    //    .frame(width:350, height:50)
                    //    .foregroundColor(.white)
                    //    .cornerRadius(10)
                    
                    //  First red
                    let fTitle = "Pre Session Reflection"
                    let fColor = Color.red
                    let fBody = "Recall a new idea you had\nrecently. What led to that idea\nand how can you make time\nfor those things."
                    
                    boxStackView(titleText:fTitle, bodyText:fBody, backColor:fColor, newSession: newSession)
                    
                    Spacer().frame(height:20)
                    
                    //  Second purple
                    let sTitle = "Post Session Reflection"
                    let sColor = Color.purple
                    let sBody = "Write about an important friend\nor family member. Include an\naudio recording if possible."
                    
                    boxStackView(titleText:sTitle, bodyText:sBody, backColor: sColor, newSession: newSession)
                    
                    Spacer().frame(height:20)
                    
                    //  Third blue
                    let tTitle = "Open Free Write"
                    let tColor = Color.blue
                    let tBody = "Write about an whatever your\nheart desires!."
                    
                    boxStackView(titleText:tTitle, bodyText:tBody, backColor: tColor, newSession:newSession)
                }
            }.environmentObject(globalCluster)
        }
        .ignoresSafeArea()
        .onAppear()
        {
            context.insert(newSession)
            context.insert(newSession2)
            context.insert(newSession3)
        }
        //.environmentObject(globalCluster)
        
        //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct boxStackView: View
{
    @State var titleText = ""
    var bodyText = ""
    var backColor = Color.red
    var newSession:SessionEntry
    
    init(titleText:String, bodyText:String, backColor:Color, newSession:SessionEntry)
    {
        self._titleText = State(initialValue: titleText)
        self.backColor = backColor
        self.bodyText = bodyText
        self.newSession = newSession
        
        //context.insert(newSession)
    }
    
    var body: some View
    {
        NavigationLink(destination:QueryView(currentSession: newSession))
        {
            ZStack
            {
                Rectangle()
                    .frame(width:350, height:200)
                    .foregroundColor(backColor)
                    .cornerRadius(20)
                
                VStack(alignment:.leading)
                {
                    Text(titleText)
                        .foregroundColor(.white)
                        .font(.system(size:20.0))
                        .padding(10)
                        .frame(width:350, alignment: .topLeading)
                    
                    Text(bodyText)
                        .foregroundColor(.white)
                        .font(.system(size:23.0).bold())
                        .padding(10)
                        .frame(width:350, height:130, alignment: .bottomLeading)
                        .multilineTextAlignment(.leading)
                }.frame(height:200)
            }
            .frame(maxWidth:.infinity, alignment: .center)
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SessionEntry.self, configurations: config)
    
    return JournalView().modelContainer(container)
}
