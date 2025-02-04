//
//  ViewB.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/15/24.
//  TRACKING TAB

import SwiftUI
import SwiftData

struct ViewB: View 
{
    @State private var isShowingSheet = false;
    @State private var isShowingInsight = false;
    
    @Query var feelings:[FeelingEntry]
    @Environment(\.modelContext) var context
    
    @State var feelingToEdit:FeelingEntry?
    
    var body: some View
    {
        ZStack
        {
            Rectangle().fill(Color("BGRev1")).ignoresSafeArea()
            
            VStack
            {
                Spacer()
                Text("Tracking")
                    .foregroundColor(.black)
                    .font(.openSansRegular(size: 45))
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
                                .frame(width: 35, height: 35)
                            Text("Insights")
                                .font(.openSansRegular(size: 15))
                        }
                    }
                }
                .frame(width:400, height:55)
                .background(Color("ShGreen").opacity(0.4))
                
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
            InsightsView(data:[])
        })
        .sheet(isPresented: $isShowingSheet, content: {
            //let config = ModelConfiguration(isStoredInMemoryOnly: true)
            //let container = try! ModelContainer(for: FeelingEntry.self, configurations: config)
            FeelingsView(passedFeeling:feelingToEdit)///.modelContainer(container)
        })
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
            Spacer().frame(width: 20)
            
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
                    .frame(width:60)
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
            
            Spacer().frame(width: 20)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: FeelingEntry.self, configurations: config)
    
    return ViewB().modelContainer(container)
}
