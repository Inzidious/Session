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
            Rectangle().fill(Color("BGRev1"))
            NavigationStack
            {
                VStack
                {
                    ZStack
                    {
                        Ellipse().fill(Color("ShTeal")).opacity(0.5).frame(width: 310, height:180)
                            .overlay( /// apply a rounded border
                                Ellipse()
                                    .stroke(.black, lineWidth: 5)).padding(.horizontal, 20)
                        VStack
                        {
                            Spacer().frame(height:40)
                            Text("Generate")
                                .foregroundColor(.black).opacity(0.5)
                                .font(.system(size:50.0))
                            
                            Text("What's on your mind this week")
                                .foregroundColor(.black).opacity(1)
                                .font(.system(size:20.0))
                                .frame(width:260).multilineTextAlignment(.center)
                        }
                    }
                    
                    Spacer().frame(height:20)
                    
                    ZStack
                    {
                        Ellipse().fill(Color("ShTeal")).opacity(0.5).frame(width: 310, height:180)
                            .overlay( /// apply a rounded border
                                Ellipse()
                                    .stroke(.black, lineWidth: 5)).padding(.horizontal, 20)
                        
                        VStack
                        {
                            Spacer().frame(height:40)
                            Text("Expand")
                                .foregroundColor(.black).opacity(0.5)
                                .font(.system(size:50.0))
                            
                            Text("Ah-Ha moments from session")
                                .foregroundColor(.black).opacity(1)
                                .font(.system(size:20.0))
                                .frame(width:260).multilineTextAlignment(.center)
                        }
                            
                    }
                    
                    Spacer().frame(height:20)
                    
                    //  Third blue
                    ZStack
                    {
                        Ellipse().fill(Color("ShTeal")).opacity(0.5).frame(width: 310, height:180)
                            .overlay( /// apply a rounded border
                                Ellipse()
                                    .stroke(.black, lineWidth: 5)).padding(.horizontal, 20)
                        
                        Text("Dream")
                            .foregroundColor(.black).opacity(0.5)
                            .font(.system(size:50.0))
                            .padding(10)
                            
                    }
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
