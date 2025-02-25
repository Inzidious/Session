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
    
    @State private var user:User? = nil
    @State private var newUserSheet:Bool = false;
    @State private var _confirmed:Bool = false;
    @State private var newsSheet:Bool = false;
    @State private var bodyText:String = "";
    
    @Query var userList:[User]
    @State private var pageNodes:[PageNode]?
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                Rectangle().fill(Color("BGRev1"))
                ScrollView {
                    VStack //NavigationStack
                    {
                        HStack {
                            NavigationLink(destination: ProfileView()) {
                                Image(systemName: "person.circle.fill")
                                    .scaleEffect(1.9)
                                    .font(.title2)
                                    .symbolRenderingMode(.palette) // Enable multi-color support
                                    .foregroundStyle(
                                        Color(red: 225/255, green: 178/255, blue: 107/255), // Foreground color
                                        Color(red: 249/255, green: 240/255, blue: 276/255)  // Background color
                                    )
                            }
                            .padding(.leading, 50)
                            Spacer()
                            
                            NavigationLink(destination: CreateReminderView()) {
                                Image(systemName: "bell.badge.fill")
                                    .scaleEffect(1.3)
                                    .font(.title2)
                                    .symbolRenderingMode(.palette) // Enable multi-color support
                                    .foregroundStyle(
                                        Color(red: 249/255, green: 240/255, blue: 276/255), // Foreground color
                                        Color(red: 225/255, green: 178/255, blue: 107/255)// Background color
                                    )
                                        
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                        .padding(.trailing, 50)
                        
                        VStack
                        {
                            Spacer().frame(height:75)
                            
                            if(user != nil)
                            {
                                Text("Welcome back, " + (user?.firstName! ?? "Shauna") + "!")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .font(.openSansSoftBold(size: 28))
                            }
                            
                            LazyVGrid(columns: [
                                GridItem(.adaptive(minimum: 130), spacing: 20)
                            ], spacing: 20) {
                                NavigationLink(destination:JournalView())
                                {
                                    smallBoxImage()
                                }
                                
                                NavigationLink(destination: SessionListView(
                                    assetCategory: .constant(""),
                                    assetType: .breathing
                                )) {
                                    smallBoxImage(boxText: "breath")
                                }
                                
                                smallBoxImage(boxText: "movement")
                                
                                NavigationLink(destination: SessionMeditation(
                                    assetCategory: .constant("")
                                )) {
                                    smallBoxImage(boxText: "meditation")
                                }
                            }
                            .padding(.horizontal, 40)
                            
                            Image("healthnews")
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                
                            
                            if(pageNodes != nil)
                            {
                                ForEach(pageNodes!, id: \.self)
                                { pageNode in
                                    
                                    Button()
                                    {
                                        bodyText = pageNode.body
                                        newsSheet = true;
                                        
                                    }
                                    label:
                                    {
                                        let result = pageNode.title.replacingOccurrences(of: "      ", with: "")
                                        NewsViewTopic(title:result,
                                                      imageUrl: pageNode.topic,
                                                      siteName: pageNode.topic,
                                                      summary: pageNode.body)
                                    }
                                }
                            }
                            
                            Spacer().frame(height: 90)
                        }.task
                        {
                            do
                            {
                                try await pageNodes = getExNodes()
                            }
                            catch
                            {}
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear()
            {
                if(userList.count == 0)
                {
                    newUserSheet = true
                }
                else
                {
                    self.user = userList[0]
                }
            }
            .sheet(isPresented: $newUserSheet)
            {
                AuthenticationView(user: $user, confirmed: $_confirmed)
            }
            .sheet(isPresented: $newsSheet)
            {
                NewsView(text: $bodyText)
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
        Image(boxText)
            .resizable()
            .frame(width: 110, height: 110)
            .scaledToFit()
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: SessionEntry.self,
        User.self,
        configurations: config
    )
    
    return ViewC().modelContainer(container)
}
