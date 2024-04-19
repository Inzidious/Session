//
//  JournalView.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/22/24.
//

import SwiftUI

struct JournalView: View 
{
    var body: some View
    {
        ZStack
        {
            Rectangle().fill(Color("BGColor"))
            NavigationView
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
                    
                    boxStackView(titleText:fTitle, bodyText:fBody, backColor:fColor)
                    
                    Spacer().frame(height:20)
                    
                    //  Second purple
                    let sTitle = "Post Session Reflection"
                    let sColor = Color.purple
                    let sBody = "Write about an important friend\nor family member. Include an\naudio recording if possible."
                    
                    boxStackView(titleText:sTitle, bodyText:sBody, backColor: sColor)
                    
                    Spacer().frame(height:20)
                    
                    //  Third blue
                    let tTitle = "Open Free Write"
                    let tColor = Color.blue
                    let tBody = "Write about an whatever your\nheart desires!."
                    
                    boxStackView(titleText:tTitle, bodyText:tBody, backColor: tColor)
                }
            }
        }.ignoresSafeArea()
        
        //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    JournalView().modelContainer(for:SessionEntry.self)
}

struct boxStackView: View
{
    @State var titleText = ""
    var bodyText = ""
    var backColor = Color.red
    
    var body: some View
    {
        NavigationLink(destination:QueryView(reflectionText : titleText))
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
            }.frame(maxWidth:.infinity, alignment: .center)
        }
    }
}
