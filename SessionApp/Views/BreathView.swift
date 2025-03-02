//
//  BreathView.swift
//  SessionApp
//
//  Created by Shawn McLean on 5/9/24.
//

import SwiftUI
import AVFoundation

struct BreathView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var duration: CGFloat = 1.0
    @State public var durationUp = 3.0
    @State public var durationDown = 3.0
    @State public var delayUp = 1.0
    @State public var delayDown = 1.0
    @State private var viewID = 0
    
    @State private var pValue = 1.0
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color("BGRev1")).ignoresSafeArea()
            
            VStack {
                // Back button
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left.circle")
                            .font(.title2)
                            .foregroundColor(Color(#colorLiteral(red: 0.8823529412, green: 0.6941176471, blue: 0.4156862745, alpha: 1)))
                            .scaleEffect(1.25)
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
                .padding(.top, 5)
                
                // Main content
                HStack(spacing: 20) {
                    // Left side - Controls
                    VStack(spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Up duration")
                                .foregroundColor(.black)
                                .font(.caption)
                            TextField("", value: self.$durationUp, format: .number)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Down duration")
                                .foregroundColor(.black)
                                .font(.caption)
                            TextField("", value: self.$durationDown, format: .number)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Up hold")
                                .foregroundColor(.black)
                                .font(.caption)
                            TextField("", value: self.$delayUp, format: .number)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Down hold")
                                .foregroundColor(.black)
                                .font(.caption)
                            TextField("", value: self.$delayDown, format: .number)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding()
                    .frame(width: 150)
                    
                    // Right side - Animation
                    ZStack {
                        VStack {
                            Image("top_first").offset(x:-12)
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width:30, height:350)
                                .offset(y:-19)
                            Image("bot_first")
                                .resizable()
                                .frame(width:120, height:140)
                                .offset(x:2, y:-31)
                        }
                        
                        ResetCirc(durationUp: self.durationUp,
                                durationDown: self.durationDown,
                                delayUp: self.delayUp,
                                delayDown: self.delayDown)
                            .id(viewID)
                            .offset(y:170)
                    }
                    .offset(y:20)
                }
                .onChange(of: [durationUp, durationDown, delayUp, delayDown]) {
                    viewID += 1
                }
                
                Spacer()
            }
        }
    }
}

struct MediaBoxEntry: View {
    var bodyText = ""
    var imageName = "play.circle"
    var boxHeight = 200.0
    var backColor = Color.red
    var answerText = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(backColor)
                .cornerRadius(10)
                .border(Color.black)
            
            HStack {
                Text(bodyText)
                    .foregroundColor(.black)
                    .font(Font.custom("Papyrus", size: 20))
                    .padding(.leading, 7)
                
                Spacer()
                    
                VStack {
                    Image(systemName: "play.circle")
                    Spacer().frame(height: 10)
                    Text("2 Min")
                        .foregroundColor(.black)
                        .font(Font.custom("Papyrus", size: 15))
                        .frame(width: 60)
                }
                
                Image(imageName)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    BreathView()
}
