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
    @Environment(\.dismiss) var dismiss
    
    var newSession:SessionEntry
    var newSession2:SessionEntry
    var newSession3:SessionEntry
    
    init()
    {
        newSession = SessionEntry(timestamp: .now, sessionLabel: 1, name:"First", user:GlobalUser.shared.user)
        newSession2 = SessionEntry(timestamp: .now, sessionLabel: 1, name:"Second", user:GlobalUser.shared.user)
        newSession3 = SessionEntry(timestamp: .now, sessionLabel: 1, name:"Third", user:GlobalUser.shared.user)
    }
    
    var body: some View
    {
        VStack
        {
            ZStack
            {
                Rectangle().fill(Color("BGRev1"))
                //NavigationView
                //{
                    VStack
                    {
                        NavigationLink(destination:QueryView(currentSession: newSession)
                            .environmentObject(globalCluster)
                            .navigationBarBackButtonHidden(true))
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
                        }
                        
                        Spacer().frame(height:20)
                        
                        NavigationLink(destination: Expand_Journal(currentSession: newSession2).environmentObject(globalCluster))
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
                                    Text("Expand")
                                        .foregroundColor(.black).opacity(0.5)
                                        .font(.system(size:50.0))
                                    
                                    Text("Ah-Ha moments from session")
                                        .foregroundColor(.black).opacity(1)
                                        .font(.system(size:20.0))
                                        .frame(width:260).multilineTextAlignment(.center)
                                }
                                
                            }
                        }
                        
                        Spacer().frame(height:20)
                        
                        NavigationLink(destination: JournalDreamView(currentSession: newSession3).environmentObject(globalCluster))
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
                                    Text("Dream")
                                        .foregroundColor(.black).opacity(0.5)
                                        .font(.system(size:50.0))
                                    
                                    Text("Plant seeds for what is growing")
                                        .foregroundColor(.black).opacity(1)
                                        .font(.system(size:20.0))
                                        .frame(width:260).multilineTextAlignment(.center)
                                }
                            }
                        }
                    }
                //}
            }
            
            //.ignoresSafeArea()
            .onAppear()
            {
                context.insert(newSession)
                context.insert(newSession2)
                context.insert(newSession3)
            }
            
        }
        .environmentObject(globalCluster)
        .navigationBarBackButtonHidden(true)
        .toolbar
        {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left.circle")
                            .font(.title2)
                            .foregroundStyle(Color(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745))
                            
                    }
                }
                .padding(.leading, 10)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person.circle.fill")
                        .scaleEffect(1.2)
                        .font(.title2)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            Color(red: 225/255, green: 178/255, blue: 107/255),
                            Color(red: 249/255, green: 240/255, blue: 276/255)
                        )
                        .padding()
                }
            }
        }
        
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
    let container = try! ModelContainer(for: SessionEntry.self, Reminder.self, configurations: config)
    
    var _ = GlobalUser.shared.setContext(context:container.mainContext)
    
    return NavigationView
    {
        JournalView()
    }.modelContainer(container)
}
