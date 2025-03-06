//
//  BreathView.swift
//  SessionApp
//
//  Created by Shawn McLean on 5/9/24.
//

import SwiftUI
import CachedAsyncImage
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
