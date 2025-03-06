//
//  FullPlayerView.swift
//  SessionApp
//
//  Created by Shawn McLean on 10/22/24.
//

import SwiftUI
import AVKit
import CachedAsyncImage

struct FullPlayerView: View {
    let audioFile = "s_audioknkn"
    @Environment(\.dismiss) private var dismiss
    
    @State private var player: AVPlayer?
    @State private var playerItem:AVPlayerItem?
    @State private var isplaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    
    public var assetToPlay:LoadedAsset
    
    //public var urlString:String
    
    var body: some View {
        VStack {
            ZStack {
                /*HStack {
                    ModifiedButtonView(image: "arrow.left")
                    
                    Spacer()
                    
                    ModifiedButtonView(image: "line.horizontal.3.decrease")
                }*/
                
                Text("Now Playing")
                    .fontWeight(.bold)
                    .foregroundColor(.black.opacity(0.8))
            }
            .padding(.all)
            
            CachedAsyncImage(url: URL(string: assetToPlay.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width:150, height:150)
                        .aspectRatio(contentMode: .fill)
                        //.padding(.horizontal, 55)
                        .clipShape(Circle())
                        .padding(.all, 4)
                        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.35), radius: 8, x: 8, y: 8)
                        .shadow(color: Color.white, radius: 10, x: -10, y: -10)
                        //.padding(.top, 35)
                } else if phase.error != nil {
                    Text("No image available")
                } else {
                    Image(systemName: "photo")
                }
            }
            //.frame(width:50, height:50)
            //.border(Color.gray)
            
            /*Image("tree")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 55)
                .clipShape(Circle())
                .padding(.all, 8)
                .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.35), radius: 8, x: 8, y: 8)
                .shadow(color: Color.white, radius: 10, x: -10, y: -10)
                .padding(.top, 35)*/
            
            Text(assetToPlay.title)
                .font(.title)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 25)
            
            Text(assetToPlay.author)
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 2)
            
            VStack {
                HStack {
                    Text(timeString(time: currentTime))
                    Spacer()
                    Text(timeString(time: totalTime))
                }
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
                .padding([.top, .trailing, .leading], 20)
                
                Slider(value: Binding(get: {
                    currentTime
                }, set: { newValue in
                    audioTime(to: newValue)
                }), in: 0...totalTime)
                .padding([.top, .trailing, .leading], 20)
            }
            
            HStack(spacing: 20) {
                Button(action: {
                    var newTime = currentTime - 20
                    if newTime < 0 {
                        newTime = 0
                    }
                    
                    audioTime(to: newTime)
                    
                }, label: {
                    ModifiedButtonView(image: "backward.fill")
                })
                
                Button {} label: {
                    Image(systemName: isplaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 14, weight: .bold))
                        .padding(.all, 25)
                        .foregroundColor(.black.opacity(0.8))
                        .background(
                            ZStack {
                                Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                                
                                Circle()
                                    .foregroundColor(.white)
                                    .blur(radius: 4)
                                    .offset(x: -8, y: -8)
                                
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8980392157, green: 0.933333333, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .padding(2)
                                    .blur(radius: 2)
                            }
                            .clipShape(Circle())
                            .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                            .shadow(color: Color.white, radius: 20, x: -20, y: -20))
                        .onTapGesture {
                            isplaying ? stopAudio() : playAudio()
                        }
                    
                }
                
                Button {
                    var newTime = currentTime + 20
                    if newTime > totalTime{
                        newTime = totalTime
                    }
                    
                    audioTime(to: newTime)
                } label: {
                    ModifiedButtonView(image: "forward.fill")
                }

            }
            .padding(.top, 25)
            Spacer()
            Button("Cancel"){dismiss()}
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.8980392157, green: 0.9333333333, blue: 1, alpha: 1)))
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
        }
        .task{
            
            do{
                try await setupAudio()
            } catch {
                
            }
            
            
        }
    }
    
    private func setupAudio() async throws
    {
        let url = URL(string: self.assetToPlay.url)
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
            
        if let piUnwr = playerItem
        {
            do  {
                let duration : CMTime = try await piUnwr.asset.load(.duration)
                let seconds : Float64 = CMTimeGetSeconds(duration)
                totalTime = seconds
            } catch {
                
            }
        }
        else
        {
            totalTime = 0
        }
    }
    
    private func playAudio() {
        player?.play()
        isplaying = true
    }
    
    private func stopAudio() {
        player?.pause()
        isplaying = false
    }
    
    private func updateProgress() {
        if let piUnwr = playerItem
        {
            let duration : CMTime = piUnwr.currentTime()
            let seconds : Float64 = CMTimeGetSeconds(duration)
            currentTime = seconds
        }
    }
    
    private func audioTime(to time: TimeInterval) 
    {
        if let plUnwr = player
        {
            let seconds : Int64 = Int64(time)
            let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
            plUnwr.seek(to: targetTime)
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
}

struct ModifiedButtonView: View {
    var image: String
    
    var body: some View {
        //Button(action: {}, label: {
            Image(systemName: image)
                .font(.system(size: 14, weight: .bold))
                .padding(.all, 25)
                .foregroundColor(.black.opacity(0.8))
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1))
                        
                        Circle()
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8980392157, green: 0.933333333, blue: 1, alpha: 1)), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(2)
                            .blur(radius: 2)
                    }
                        .clipShape(Circle())
                        .shadow(color: Color(#colorLiteral(red: 0.7608050108, green: 0.8164883852, blue: 0.9259157777, alpha: 1)), radius: 20, x: 20, y: 20)
                        .shadow(color: Color.white, radius: 20, x: -20, y: -20)
                )
        //})
    }
}

#Preview {
    //let urlString = "https://thereapymuse.sfo2.digitaloceanspaces.com/Anxiety_Reduction.mp3"
    FullPlayerView(assetToPlay:GlobalManifest.shared.manifest[5])
}
