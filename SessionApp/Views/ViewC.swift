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
    private let adaptiveColumns = [GridItem(.adaptive(minimum:sqsize))]
    @StateObject var data = SpaceAPI()
    
    var body: some View
    {
        ZStack
        {
            Rectangle().fill(Color("BGColor"))
            NavigationStack
            {
                VStack
                {
                    Spacer().frame(height:15)
                    
                    Text("Good afternoon, Shauna!")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(Font.custom("Papyrus", size:28))
                    
                    LazyVGrid(columns:adaptiveColumns,
                              spacing:10)
                    {
                        smallBoxStack()
                        smallBoxStack(boxText: "Breath")
                        smallBoxStack(boxText: "Meditation")
                        smallBoxStack(boxText: "Focus")
                    }
                    .padding()
                    .frame(alignment: .top)
                    
                    Divider()
                        .overlay(Color.black)
                        .frame(minHeight:20)
                    
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

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SessionEntry.self, configurations: config)
    
    return ViewC().modelContainer(container)
}
