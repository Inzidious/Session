//
//  ResourceDetails.swift
//  SessionApp
//
//  Created by Shawn McLean on 9/26/24.
//

import SwiftUI

struct ResourceDetails: View {
    @State private var isShowingTop = true
    @State private var isShowingCalm = false
    @State private var isShowingEnergize = false
    @State private var isShowingGuided = false
    @State private var isShowingAnimations = false
    
    @State private var isShowingAssets = false
    
    @State private var assetCategory:String = "None"
    @Environment(\.dismiss) private var dismiss
    
    let selectedTopic: String
    
    var txtString:[String] = ["Education",
                              "Tracks",
                              "Courses",
                              "Social Support"]
    
    var imgString:[String] = ["waves",
                              "woman_calm",
                              "medi_sphere",
                              "box_breathing"]
    
    var indexer:Int = 0
    
    var body: some View
    {
        VStack
        {
            // Custom back button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left.circle")
                        .font(.title2)
                        .foregroundColor(Color(#colorLiteral(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745, alpha: 1)))
                        .scaleEffect(1.25)
                }
                .padding(.leading, 20)
                Spacer()
            }
            .padding(.top, 5)
            
            Text(selectedTopic + " Resources")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(Font.custom("OpenSans-SemiBold", size:24))
                .padding()
        
            Spacer()
            
            ScrollView(.horizontal)
            {
                HStack
                {
                    Button
                    {
                        isShowingTop = true
                        isShowingCalm = false
                        isShowingEnergize = false
                        isShowingGuided = false
                        isShowingAnimations = false
                    }
                    label:
                    {
                        Text("Top")
                            
                            .font(Font.custom("OpenSans-SemiBold", size:19))
                    }.padding(5)
                    
                    Button
                    {
                        isShowingTop = false
                        isShowingCalm = true
                        isShowingEnergize = false
                        isShowingGuided = false
                        isShowingAnimations = false
                    }
                    label:
                    {
                        Text("Calm")
                            
                            .font(Font.custom("OpenSans-SemiBold", size:19))
                    }
                    
                    Button
                    {
                        isShowingTop = false
                        isShowingCalm = false
                        isShowingEnergize = true
                        isShowingGuided = false
                        isShowingAnimations = false
                    }
                    label:
                    {
                        Text("Energize")
                            
                            .font(Font.custom("OpenSans-SemiBold", size:19))
                    }
                    
                    Button
                    {
                        isShowingTop = false
                        isShowingCalm = false
                        isShowingEnergize = false
                        isShowingGuided = true
                        isShowingAnimations = false
                    }
                    label:
                    {
                        Text("Guided")
                            
                            .font(Font.custom("OpenSans-SemiBold", size:19))
                    }
                    
                    Button
                    {
                        isShowingTop = false
                        isShowingCalm = false
                        isShowingEnergize = false
                        isShowingGuided = false
                        isShowingAnimations = true
                    }
                    label:
                    {
                        Text("Animations")
                            
                            .font(Font.custom("OpenSans-SemiBold", size:19))
                    }
                    
                }.foregroundStyle(
                    LinearGradient(
                        colors: [.black, .black],
                        startPoint: .top,
                        endPoint: .bottom))
                
                
            }.padding(1).background(Color("ShGreen").opacity(0.4))
            
            
            if(isShowingTop)
            {
                List()
                {
                    ForEach(0..<11)
                    { indexer in
                        Button()
                        {
                            assetCategory = txtString[indexer%4]
                            isShowingAssets = true
                        }
                    label:
                        {
                            CategoryBoxEntry(bodyText: txtString[indexer%4],
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
            ResourceAssets(assetCategory:$assetCategory)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct CategoryBoxEntry: View
{
    var bodyText = ""
    var imageName = "play.circle"
    var boxHeight = 300.0;
    var backColor = Color.red
    var answerText = ""
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
            .frame(width:340, height:boxHeight)
                .foregroundColor(backColor)
                .cornerRadius(10)
                .border(Color(red: 250/255, green: 249/255, blue: 246/255))
            
            HStack
            {
                Text(bodyText)
                    .foregroundColor(.black)
                    .font(Font.custom("OpenSans-SemiBold", size:30))
                    .padding(10)
                
                Spacer()
                Image(imageName).resizable().frame(width:50, height:50).padding(10)
            }
            
        }.frame(maxWidth:.infinity, alignment: .center)
    }
}

#Preview {
    ResourceDetails(selectedTopic: "Depression")
}
