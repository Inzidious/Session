//
//  NewsView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/8/24.
//

import SwiftUI
import CachedAsyncImage

struct NewsView: View
{
    @Binding var text:String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View
    {
        Button()
        {
            dismiss()
        }
        label:
        {
            ZStack
            {
                Rectangle()
                    .frame(maxWidth:.infinity)
                    .foregroundColor(Color(.black).opacity(0.5))
                    .padding(.horizontal, 20)
                
                Text("Back").font(Font.custom("Roboto", size:25)).foregroundColor(.white)
            }.frame(width:130, height:40)
        }.padding()
        
        VStack
        {
            ScrollView
            {
                Text(text)
            }.padding(1)
        }
    }
}

struct NewsViewTopic: View {
    
    var title : String = ""
    var imageUrl : String = ""
    var siteName : String = ""
    var summary : String = ""
    
    var body: some View 
    {
        VStack(alignment: .leading)
        {
            /*HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            {
                CachedAsyncImage(url:URL(string:imageUrl),
                                 transaction:Transaction(animation: .easeInOut))
                                 { phase in
                                     if let image = phase.image
                                     {
                                         image
                                             .resizable()
                                             .scaledToFit()
                                             .clipShape(RoundedRectangle(cornerRadius: 20))
                                         
                                     }
                                     else
                                     {}
                    
                }
            }*/
            
            ZStack
            {
                RoundedRectangle(cornerRadius: 25)
                .frame(height:70)
                    .foregroundColor(Color(.white).opacity(0))
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 5)).padding(.horizontal, 20)
                
                VStack
                {
                    Text(title)
                        .font(.headline)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                        .foregroundColor(Color(.black).opacity(1))
                }
            }
        }
    }
}

#Preview {
    NewsView(text: .constant("Test"))
}
