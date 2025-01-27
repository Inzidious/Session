//
//  ViewC.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/15/24.
//

import SwiftUI
import SwiftData

let sqsize:CGFloat = 100;
let fontSize:CGFloat = 20;
let numSquares:Int = 4

struct ViewC: View
{
    @Environment(\.modelContext) var context;
    
    private let adaptiveColumns = [GridItem(.adaptive(minimum:sqsize))]
    @StateObject var data = SpaceAPI()
    
    @State private var currentUser:CurrentUser? = nil
    @State private var newUserSheet:Bool = false;
    @State private var _confirmed:Bool = false;
    
    @Query var currentUserList:[CurrentUser]
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                Rectangle().fill(Color("BGRev1"))
                VStack //NavigationStack
                {
                    VStack
                    {
                        Spacer().frame(height:75)
                        
                        if(currentUser != nil)
                        {
                            Text("Welcome back, " + currentUser!.firstName + "!")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(Font.custom("Roboto", size:28))
                        }
                        
                        LazyVGrid(columns:adaptiveColumns,
                                  spacing:40)
                        {
                            /*smallBoxStack()
                             smallBoxStack(boxText: "Breath")
                             smallBoxStack(boxText: "Meditation")
                             smallBoxStack(boxText: "Focus")*/
                            
                            NavigationLink(destination:JournalView())
                            {
                                smallBoxImage().padding(.leading, 50)
                            }
                            
                            Spacer().frame(width: 5)
                            
                            NavigationLink(destination:BreathView())
                            {
                                smallBoxImage(boxText: "breath").padding(.trailing, 50)
                            }
                            
                            smallBoxImage(boxText: "movement").padding(.leading, 50)
                            Spacer().frame(width: 5)
                            smallBoxImage(boxText: "meditation").padding(.trailing, 50)
                            
                            
                        }
                        .padding()
                        .frame(alignment: .top)
                        
                        Image("healthnews")
                        
                        if(data.news.count > 0)
                        {
                            NewsView(title:data.news[0].title,
                                     imageUrl: data.news[0].imageUrl,
                                     siteName: data.news[0].newsSite,
                                     summary: data.news[0].summary)
                        }
                        
                        Spacer()
                        
                    }.task
                    {
                        do
                        {
                            try await data.getData()
                        }
                        catch
                        {}
                    }
                    .frame(alignment: .top)
                }
            }
            .ignoresSafeArea()
            .onAppear()
            {
                if(currentUserList.count == 0)
                {
                    newUserSheet = true
                }
                else
                {
                    self.currentUser = currentUserList[0]
                }
            }
            .sheet(isPresented: $newUserSheet)
            {
                NewUserView(currentUser:$currentUser, confirmed:$_confirmed).onDisappear()
                {
                    //print("dipped")
                }
            }
        }
    }
}

struct smallBoxStack: View
{
    var boxText = "Journal"
    
    var body: some View
    {
        NavigationLink(destination:JournalView())
        {
            ZStack
            {
                Rectangle()
                    .frame(width:sqsize, height:sqsize)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x:10, y:10)
            
                Text(boxText)
                    .foregroundColor(.black)
                    .font(Font.custom("Papyrus", size: 20))
            }
        }
    }
}

struct smallBoxImage: View
{
    var boxText = "journal"
    
    var body: some View
    {
        Image(boxText).resizable().frame(width:130, height:130)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SessionEntry.self, CurrentUser.self, configurations: config)
    
    return ViewC().modelContainer(container)
}
