//
//  NewsView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/8/24.
//

import SwiftUI
import CachedAsyncImage

extension String
{
    func loadAsync() -> Any
    {
        CachedAsyncImage(url:URL(string:self),
                                   transaction:Transaction(animation: .easeInOut))
        { phase in
            if let image = phase.image
            {
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                //return image
                
            }
            else
            {}
        }
    }
    
    func load() -> UIImage {
        do{
            guard let url = URL(string:self)
            else{
                return UIImage()
            }
            
            let data:Data = try Data(contentsOf: url)
            
            return UIImage(data:data) ?? UIImage()
                    
        } catch {
            
        }
        
        return UIImage()
    }
}

struct NewsView: View
{
    @Binding var text:String
    @Environment(\.dismiss) private var dismiss
    @State public var converted:AttributedString?
    
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
                if let convertedUnwr = converted
                {
                    Text(converted!)
                }
                else
                {
                    
                }
            }.padding(1)
        }.onAppear()
        {
            let nsresult = GetFormattedBodyString(body:text)
            converted = AttributedString.init(nsresult!)
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
        //VStack(alignment: .leading)
        //{
            ZStack
            {
                RoundedRectangle(cornerRadius: 25)
                .frame(height:70)
                    .foregroundColor(Color(.white).opacity(0))
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 5)).padding(.horizontal, 20)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                {
                    CachedAsyncImage(url: URL(string: imageUrl)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else if phase.error != nil {
                            Text("No image available")
                        } else {
                            Image(systemName: "photo")
                        }
                    }
                    .frame(width:50, height:50)
                    .border(Color.gray)
                    
                    Text(title)
                        .font(.headline)
                        //.padding(.leading, 5)
                        .padding(.horizontal)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(.black).opacity(1))
                }.frame(width:370)
            }
        //}
    }
}

#Preview {
    NewsView(text: .constant("Test"))
}
