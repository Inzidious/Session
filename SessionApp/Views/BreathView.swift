//
//  BreathView.swift
//  SessionApp
//
//  Created by Shawn McLean on 5/9/24.
//

import SwiftUI
import AVFoundation

struct BreathView: View {
    
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
                
                // Bottom Navigation
                HStack(spacing: 0) {
                    ForEach(0..<4, id: \.self) { index in
                        NavigationLink(destination: destinationView(for: index)) {
                            VStack {
                                Image(systemName: iconName(for: index))
                                Text(tabName(for: index))
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.vertical, 8)
                .background(Color.white)
            }
        }
        .navigationBarHidden(true)
    }
    
    private func destinationView(for index: Int) -> some View {
        switch index {
        case 0: return AnyView(ViewC())  // Home
        case 1: return AnyView(Text("Tracking"))
        case 2: return AnyView(Text("Resources"))
        case 3: return AnyView(Text("Community"))
        default: return AnyView(ViewC())
        }
    }
    
    private func iconName(for index: Int) -> String {
        ["house", "chart.bar", "book", "globe"][index]
    }
    
    private func tabName(for index: Int) -> String {
        ["Home", "Tracking", "Resources", "Community"][index]
    }
}

struct BreathViewOld: View
{
    @State private var isShowingTop = true
    @State private var isShowingTrack = false
    @State private var isShowingCourses = false
    @State private var isShowingSessions = false
    @State private var isShowingGroups = false
    @State private var isShowingPlayer = false
    
    var txtString:[String] = ["3 Minutes to Calm",
                              "Sama Vritti - Even Breath",
                              "Alternate Nostril Breathing",
                              "Box Breathing"]
    
    var imgString:[String] = ["waves",
                              "woman_calm",
                              "medi_sphere",
                              "box_breathing"]
    
    var indexer:Int = 0
    
    var body: some View
    {
        VStack
        {
            Spacer().frame(height:40)
            
            ScrollView(.horizontal)
            {
                HStack
                {
                    Button("Top")
                    {
                        isShowingTop = true
                        isShowingTrack = false
                        isShowingCourses = false
                        isShowingSessions = false
                        isShowingGroups = false
                    }
                    Button("Track")
                    {
                        isShowingTop = false
                        isShowingTrack = true
                        isShowingCourses = false
                        isShowingSessions = false
                        isShowingGroups = false
                    }
                    Button("Courses")
                    {
                        isShowingTop = false
                        isShowingTrack = false
                        isShowingCourses = true
                        isShowingSessions = false
                        isShowingGroups = false
                    }
                    Button("Sessions")
                    {
                        isShowingTop = false
                        isShowingTrack = false
                        isShowingCourses = false
                        isShowingSessions = true
                        isShowingGroups = false
                    }
                    Button("Groups")
                    {
                        isShowingTop = false
                        isShowingTrack = false
                        isShowingCourses = false
                        isShowingSessions = false
                        isShowingGroups = true
                    }
                    Button("Entertainment")
                    {}
                    Button("History")
                    {}
                    Button("Entertainment")
                    {}
                }
            }.padding()
            
            
            if(isShowingTop)
            {
                List()
                {
                    ForEach(0..<11)
                    { indexer in
                        Button()
                        {
                            isShowingPlayer = true
                        }
                    label:
                        {
                            MediaBoxEntry(bodyText: txtString[indexer%4],
                                          imageName:imgString[indexer%4],
                                          boxHeight:70,
                                          backColor:.white)
                        }
                    }
                }
            }
            
            if(isShowingTrack)
            {
                List()
                {
                    ForEach(1..<6)
                    { _ in
                        Button()
                        {
                            isShowingPlayer = true
                        }
                    label:
                        {
                            boxStackViewNoTitle(boxHeight:70, backColor:Color("ShGreen"))
                        }
                    }
                }
            }
            
            if(isShowingCourses)
            {
                List()
                {
                    ForEach(1..<4)
                    { _ in
                        Button()
                        {
                            isShowingPlayer = true
                        }
                    label:
                        {
                            boxStackViewNoTitle(boxHeight:70, backColor:Color("ShRed"))
                        }
                    }
                }
            }
            
            Spacer()
            
        }.sheet(isPresented: $isShowingPlayer)
        {
            let urlString = "https://thereapymuse.sfo2.digitaloceanspaces.com/Anxiety_Reduction.mp3"
            FullPlayerView(urlString:urlString)
        }
    }
}

struct PlayerView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var audioPlayerViewModel = AudioPlayerViewModel()
    
    var body: some View {
        VStack {
              Button(action: {
                audioPlayerViewModel.playOrPause()
              }) {
                Image(systemName: audioPlayerViewModel.isPlaying ? "pause.circle" : "play.circle")
                  .resizable()
                  .frame(width: 64, height: 64)
              }
            }
        Button("Cancel"){ dismiss()}
    }
}

#Preview {
    BreathView()
}

class AudioPlayerViewModel: ObservableObject {
  var audioPlayer: AVAudioPlayer?

  @Published var isPlaying = false

  init() {
    if let sound = Bundle.main.path(forResource: "sample-15s", ofType: "mp3") {
      do {
        self.audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
      } catch {
        print("AVAudioPlayer could not be instantiated.")
      }
    } else {
      print("Audio file could not be found.")
    }
  }

  func playOrPause() {
    guard let player = audioPlayer else { return }

    if player.isPlaying {
      player.pause()
      isPlaying = false
    } else {
      player.play()
      isPlaying = true
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
                    .font(Font.custom("Papyrus", size:20))
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
                        .font(Font.custom("Papyrus", size:15))
                        .frame(width:60)
                        
                }
                
                Image(imageName).resizable().frame(width:50, height:50).padding(.trailing, 10)
            }
            
        }.frame(maxWidth:.infinity, alignment: .center)
    }
}
