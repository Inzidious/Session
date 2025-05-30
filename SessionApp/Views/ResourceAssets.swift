//
//  ResourceAssets.swift
//  SessionApp
//
//  Created by Shawn McLean on 9/30/24.
//

import SwiftUI
import CachedAsyncImage
import Observation

struct ComingSoonView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Coming Soon")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This content will be provided by community members who become content partners. Please stay tuned as we update this content.")
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                // Add action for content partner signup
            }) {
                Text("Become a Content Provider Partner")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button("Close") {
                dismiss()
            }
            .padding()
        }
        .padding()
    }
}

struct ResourceAssets: View
{
    @State private var isShowingTop = true
    @State private var isShowingCalm = false
    @State private var isShowingEnergize = false
    @State private var isShowingGuided = false
    @State private var isShowingAnimations = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingAssets = false
    @State private var assetToPlay:LoadedAsset? = nil
    @State private var showComingSoon = false
    
    @Binding var assetCategory:String
    
    var txtString:[String] = ["Depression ABC",
                              "Depression XYZ",
                              "Depression DEF",
                              "Depression QRT"]
    
    var imgString:[String] = ["waves",
                              "woman_calm",
                              "medi_sphere",
                              "box_breathing"]
    
    var indexer:Int = 0
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left.circle")
                        .font(.title2)
                        .foregroundColor(Color(#colorLiteral(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745, alpha: 1)))
                        .scaleEffect(1.25)
                }
                .padding(.leading, 20)
                
                Text(assetCategory)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(Font.custom("OpenSans", size:25))
            }
            .padding(.top, 5)
        
            Spacer()
            
            if(isShowingTop)
            {
                List()
                {
                    ForEach(GlobalManifest.shared.manifest) { asset in
                        Button()
                        {
                            showComingSoon = true
                        }
                    label:
                        {
                            MediaBoxEntry(bodyText: asset.title,
                                          imageName:asset.thumbnail,
                                          boxHeight:110,
                                          backColor:.white)
                        }
                    }
                }
            }
            
            if(isShowingCalm)
            {
                List()
                {
                    ForEach(1..<6)
                    { _ in
                        Button()
                        {
                            showComingSoon = true
                        }
                    label:
                        {
                            boxStackViewNoTitle(boxHeight:70, backColor:Color("ShGreen"))
                        }
                    }
                }
            }
            
            if(isShowingEnergize)
            {
                List()
                {
                    ForEach(1..<4)
                    { _ in
                        Button()
                        {
                            showComingSoon = true
                        }
                    label:
                        {
                            boxStackViewNoTitle(boxHeight:70, backColor:Color("ShRed"))
                        }
                    }
                }
            }
            
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .sheet(isPresented: $showComingSoon) {
            ComingSoonView()
        }
    }
}

struct MediaBoxEntry: View
{
    var bodyText = ""
    var imageName = "play.circle"
    var boxHeight = 200.0;
    var backColor = Color.red
    var answerText = ""
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .foregroundColor(backColor)
                .cornerRadius(10)
                .border(Color(red: 250/255, green: 249/255, blue: 246/255))
            
            HStack
            {
                Text(bodyText)
                    .foregroundColor(.black)
                    .font(Font.custom("OpenSans", size:18))
                    .padding(.leading, 7)
                
                Spacer()
                    
                VStack
                {
                    Image(systemName: "play.circle")
                    Spacer().frame(height:10)
                    Text("2 Min")
                        .foregroundColor(.black)
                        .font(Font.custom("OpenSans", size:12))
                        .frame(width:60)
                        
                }
                
                CachedAsyncImage(url: URL(string: imageName)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                    } else if phase.error != nil {
                        Text("No image available")
                    } else {
                        Image(systemName: "photo")
                    }
                }
                .frame(width:50, height:50)
                .border(Color(red: 250/255, green: 249/255, blue: 246/255))
                .padding(.horizontal, 6)
            }
            
        }.frame(maxWidth:.infinity, alignment: .center)
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State private var previewString = "Preview"
        
        var body: some View {
            ResourceAssets(assetCategory: $previewString)
        }
    }
    
    return PreviewWrapper()
}
