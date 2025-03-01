//
//  ResourceAssets.swift
//  SessionApp
//
//  Created by Shawn McLean on 9/30/24.
//

import SwiftUI
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
                    .font(Font.custom("Papyrus", size:25))
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
                            print("asset:", self.assetToPlay!.url)
                            isShowingAssets = true
                        }
                    label:
                        {
                            MediaBoxEntry(bodyText: asset.title,
                                          imageName:imgString[indexer%4],
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

#Preview {
    struct PreviewWrapper: View {
        @State private var previewString = "Preview"
        
        var body: some View {
            ResourceAssets(assetCategory: $previewString)
        }
    }
    
    return PreviewWrapper()
}
