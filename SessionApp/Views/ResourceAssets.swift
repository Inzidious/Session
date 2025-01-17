//
//  ResourceAssets.swift
//  SessionApp
//
//  Created by Shawn McLean on 9/30/24.
//

import SwiftUI

struct ResourceAssets: View
{
    @State private var isShowingTop = true
    @State private var isShowingCalm = false
    @State private var isShowingEnergize = false
    @State private var isShowingGuided = false
    @State private var isShowingAnimations = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isShowingAssets = false
    
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
                    ForEach(0..<11)
                    { indexer in
                        Button()
                        {
                            isShowingAssets = true
                        }
                    label:
                        {
                            MediaBoxEntry(bodyText: txtString[indexer%4],
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
            
        }.sheet(isPresented: $isShowingAssets)
        {
            FullPlayerView()
        }
    }
}

#Preview {
    @State var previewString:String = "Preview"
    return ResourceAssets(assetCategory:$previewString)
}
