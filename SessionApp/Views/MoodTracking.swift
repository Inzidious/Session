//
//  MoodTracking.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/15/24.
//  TRACKING TAB

import SwiftUI
import SwiftData

struct MoodTracking: View 
{
    @State private var isShowingSheet = false;
    @State private var isShowingInsight = false;
    
    @Query var feelings:[FeelingEntry]
    @Environment(\.modelContext) var context
    
    @State var feelingToEdit:FeelingEntry?
    
    var body: some View
    {
        NavigationStack {
            ZStack
            {
                Rectangle().fill(Color("BGRev1")).ignoresSafeArea()
                
                VStack
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
                        .padding(.leading, 20)
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
                    .padding(.horizontal, 20)
                    .padding(.trailing, 20)
                    
                    Spacer()
                    HStack {
                        Image("icon_tracking")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        Text("Tracking")
                            .foregroundColor(.black)
                            .font(.openSansSoftBold(size: 40))
                    }
                    .padding(20)
                    .frame(width:350, height:50, alignment: .trailing)
                    
                    Button()
                    {
                        feelingToEdit = nil
                        isShowingSheet = true;
                    }
                    label:
                    {
                        TitleBox()
                    }
                    
                    Spacer().frame(height:20)
                    
                    
                    HStack
                    {
                        Text("History")
                            .foregroundColor(.black)
                            .font(.openSansRegular(size: 25))
                            .padding(20)
                            //.frame(width:400, height:45, alignment: .leading)
                            
                        Text("\(feelings.count) Items")
                            .foregroundColor(.black)
                            .font(.openSansRegular(size: 25))
                            .padding(20)
                        
                        
                        Button()
                        {
                            print("hrere")
                            isShowingInsight = true
                        }
                        label:
                        {
                            VStack
                            {
                                Image("insights")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 55, height: 50)
                                //Text("Insights")
                                  //  .font(.openSansRegular(size: 15))
                            }
                        }
                    }
                    .frame(width:400, height:55)
                    .background(Color("ShGreen").opacity(0.4))
                    
                    #if DEBUG
                    Button(action: {
                        clearAllData(context: context)
                        DemoDataLoader.loadDemoUser(context: context)
                    }) {
                        Rectangle()
                            .fill(Color.brown)
                            .frame(width: 40, height: 20)
                            .overlay(
                                Text("Clear")
                                    .foregroundColor(.white)
                                    .font(.caption)
                            )
                            .padding(.leading, 20)
                    }
                    #endif
                    
                    List()
                    {
                        ForEach(feelings) { feeling in
                            
                            Button()
                            {
                                feelingToEdit = feeling
                                isShowingSheet = true;
                                //context.delete(feeling)
                            }
                            label:
                            {
                                FeelingBoxEntry(feeling : feeling)
                            }
                        }
                    }
                }
            }.sheet(isPresented: $isShowingInsight, content: {
                //let config = ModelConfiguration(isStoredInMemoryOnly: true)
                //let container = try! ModelContainer(for: FeelingEntry.self, configurations: config)
                InsightsView()
            })
            .sheet(isPresented: $isShowingSheet, content: {
                //let config = ModelConfiguration(isStoredInMemoryOnly: true)
                //let container = try! ModelContainer(for: FeelingEntry.self, configurations: config)
                FeelingsView(passedFeeling:feelingToEdit)///.modelContainer(container)
            })
        }
    }
    
    func clearAllData(context: ModelContext) {
        // Delete all FeelingEntry objects
        let fetchRequest = FetchDescriptor<FeelingEntry>()
        if let feelings = try? context.fetch(fetchRequest) {
            for feeling in feelings {
                context.delete(feeling)
            }
        }
        // Optionally, delete other entities (User, etc.) here
        try? context.save()
    }
}

struct FeelingBoxEntry: View 
{
    @Bindable var feeling:FeelingEntry
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .frame(width:350, height:150)
                .opacity(0)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            VStack
            {
                Text(feeling.timestamp, style:.date)
                
                HStack
                {
                    if( feeling.feeling == 0)
                    {
                        VStack
                        {
                            Text("No Feeling")
                                .foregroundColor(.black)
                                .font(.openSansRegular(size: 18))
                                .padding(1)
                        }
                    }
                    if( feeling.feeling == 1)
                    {
                        VStack
                        {
                            Image("stellar")
                            
                            Text("Feeling Stellar!")
                                .foregroundColor(.black)
                                .font(.openSansRegular(size: 18))
                                .padding(1)
                        }
                    }
                    if( feeling.feeling == 2)
                    {
                        VStack
                        {
                            Image("great")
                            
                            Text("Feeling Great!")
                                .foregroundColor(.black)
                                .font(.openSansRegular(size: 18))
                                .padding(1)
                        }
                    }
                    if( feeling.feeling == 3)
                    {
                        VStack
                        {
                            Image("fair")
                            
                            Text("Feeling fair..")
                                .foregroundColor(.black)
                                .font(.openSansRegular(size: 18))
                                .padding(1)
                        }
                    }
                    if( feeling.feeling == 4)
                    {
                        VStack
                        {
                            Image("bad")
                            
                            Text("Feeling Bad...")
                                .foregroundColor(.black)
                                .font(.openSansRegular(size: 18))
                                .padding(1)
                        }
                    }
                    if( feeling.feeling == 5)
                    {
                        VStack
                        {
                            Image("abysmal")
                            
                            Text("Feeling Abysmal....")
                                .foregroundColor(.black)
                                .font(.openSansRegular(size: 18))
                                .padding(1)
                        }
                    }
                    
                    VStack
                    {
                        if(feeling.sleep != 0)
                        {
                            if( feeling.sleep == 1 )
                            {
                                Text("Sleep: Great")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            else if( feeling.sleep == 2 )
                            {
                                Text("Sleep: Good")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            if( feeling.sleep == 3 )
                            {
                                Text("Sleep: Low")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            if( feeling.sleep == 4 )
                            {
                                Text("Sleep: None")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                        }
                        
                        if(feeling.move != 0)
                        {
                            if( feeling.move == 1 )
                            {
                                Text("Movement: Great")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            else if( feeling.move == 2 )
                            {
                                Text("Movement: Good")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            if( feeling.move == 3 )
                            {
                                Text("Movement: Low")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            if( feeling.move == 4 )
                            {
                                Text("Movement: None")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                        }
                        
                        if(feeling.food != 0)
                        {
                            if( feeling.food == 1 )
                            {
                                Text(" Food: Great")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            else if( feeling.food == 2 )
                            {
                                Text(" Food: Good")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            if( feeling.food == 3 )
                            {
                                Text(" Food: Low")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                            if( feeling.food == 4 )
                            {
                                Text(" Food: None")
                                    .foregroundColor(.black)
                                    .font(.openSansRegular(size: 18))
                                    .padding(1)
                            }
                        }
                    }
                }
            }
            //Text("New Feeling")
        }
    }
}

struct HistoryBar: View
{
    
    @State var count:Int
    
    var body: some View
    {
        HStack
        {
            Text("History")
                .foregroundColor(.black)
                .font(.openSansRegular(size: 25))
                .padding(20)
                //.frame(width:400, height:45, alignment: .leading)
                
            Text("\(count) Items")
                .foregroundColor(.black)
                .font(.openSansRegular(size: 25))
                .padding(20)
            
            VStack
            {
                
            }
        }
        
        .frame(width:400, height:55)
        .background(Color("ShGreen").opacity(0.4))
    }
}

struct TitleBox: View
{
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .frame(width:350, height:200)
                .foregroundColor(Color("BGRev1"))
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            VStack
            {
                Text("How are you feeling?")
                    .foregroundColor(.black)
                    .font(.openSansRegular(size: 35))
                    .padding(10)
                
                ImageRow()
            }
            
        }.frame(maxWidth:.infinity, alignment: .center)
    }
}

struct ImageRow: View
{
    var body: some View
    {
        HStack
        {
            Spacer().frame(width: 31)
            
            VStack
            {
                Image("stellar")
                Text("Stellar")
                    .foregroundColor(.black)
                    .font(.openSansRegular(size: 18))
                    .padding(1)
            }
            
            Spacer()
            
            VStack
            {
                Image("great")
                Text("Great")
                    .foregroundColor(.black)
                    .font(.openSansRegular(size: 18))
                    .padding(1)
            }
            
            Spacer()
            
            VStack
            {
                Image("fair")
                Text("Fair")
                    .foregroundColor(.black)
                    .font(.openSansRegular(size: 15))
                    .padding(1)
                    .frame(width:40)
            }
            
            Spacer()
            
            VStack
            {
                Image("bad")
                Text("Bad")
                    .foregroundColor(.black)
                    .font(.openSansRegular(size: 15))
                    .padding(1)
                    .frame(width:60)
            }
            
            Spacer()
            
            VStack
            {
                Image("abysmal")
                Text("Abysmal")
                    .foregroundColor(.black)
                    .font(.openSansRegular(size: 15))
                    .padding(1)
                    .frame(width:60)
            }
            
            Spacer().frame(width: 30)
        }
    }
}

#Preview {
    let previewUser = User(
        id: UUID().uuidString,
        email: "preview@example.com",
        firstName: "Preview",
        lastName: "User",
        authProvider: "preview"
    )
    SplashScreenView(user: .constant(previewUser))
        .modelContainer(try! ModelContainer(
            for: User.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        ))
        .environmentObject(AuthManager())
}
