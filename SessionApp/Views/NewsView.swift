//
//  NewsView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/8/24.
//

import SwiftUI
import CachedAsyncImage

struct NewsView: View {
    
    var title : String = ""
    var imageUrl : String = ""
    var siteName : String = ""
    var summary : String = ""
    
    var body: some View 
    {
        VStack(alignment: .leading)
        {
            Text(siteName)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .italic()
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
            }
            
            Text(title)
                .font(.headline)
                .padding(8)
            
            Text(summary)
                .lineLimit(6)
                .font(.body)

        }
    }
}

#Preview {
    NewsView()
}
