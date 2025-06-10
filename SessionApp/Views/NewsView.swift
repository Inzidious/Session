//
//  NewsView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/8/24.
//  Update UI/UX Ahmed Shuja 6/6/2025
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
    var title: String
    @Binding var text: String
    @Environment(\.dismiss) private var dismiss
    @State public var converted: AttributedString?
    @State private var isLoading = true
    
    var body: some View
    {
        ZStack {
            Color("BGRev1")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Back Button
                HStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                                .font(.title2)
                                .foregroundColor(Color(#colorLiteral(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745, alpha: 1)))
                                .scaleEffect(1.25)
                        }
                    }
                    .padding(.leading, 50)
                    Spacer()
                }
                .padding(.top, 60)
                
                // Article Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Title
                        Text(title)
                            .font(.title)
                            .bold()
                            .padding(.horizontal, 24)
                            .padding(.top, 24)

                        // Content Box
                        VStack(alignment: .leading, spacing: 16) {
                            if let convertedUnwr = converted {
                                Text(convertedUnwr)
                                    .font(.system(size: 18))
                                    .foregroundColor(.primary)
                            } else if isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(.top, 100)
                            }
                        }
                        .padding(20)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                    }
                }
                .padding(.top, 20)
            }
        }
        .onAppear {
            isLoading = true
            let nsresult = GetFormattedBodyString(body: text)
            converted = AttributedString.init(nsresult!)
            isLoading = false
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
    NewsView(title: "Test Title", text: .constant("Test"))
}
