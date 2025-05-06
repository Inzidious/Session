//
//  ResourceAssets.swift
//  SessionApp
//
//  Created by Shawn McLean on 9/30/24.
//

import SwiftUI
import CachedAsyncImage
import Observation

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
                Button("Cancel"){ dismiss()}.padding()
                
                Text("Depression " + assetCategory)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(Font.custom("OpenSans", size:25))
            }
        
            Spacer()
            
            if(isShowingTop)
            {
                List()
                {
                    ForEach(GlobalManifest.shared.manifest) { asset in
                        Button()
                        {
                            self.assetToPlay = asset
                            //isShowingAssets = true
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
                            isShowingAssets = true
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
                            isShowingAssets = true
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
        .sheet(item: $assetToPlay) { asset in
            FullPlayerView(assetToPlay:asset)
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
            //.frame(width:350, height:boxHeight)
                .foregroundColor(backColor)
                .cornerRadius(10)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            HStack
            {
                Text(bodyText)
                    .foregroundColor(.black)
                    .font(Font.custom("OpenSans", size:18))
                    .padding(.leading, 7)
                    //.frame(width:250, alignment: .bottomLeading)
                    //.multilineTextAlignment(.leading)
                
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
                            //.aspectRatio(contentMode: .fit)
                    } else if phase.error != nil {
                        Text("No image available")
                    } else {
                        Image(systemName: "photo")
                    }
                }
                .frame(width:50, height:50)
                .border(Color.gray)
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
