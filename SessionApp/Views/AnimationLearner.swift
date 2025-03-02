//
//  AnimationLearner.swift
//  SessionApp
//
//  Created by Shawn McLean on 10/29/24.
//

import SwiftUI

struct RepeatAnimationModifier: AnimatableModifier {
    let totalDistance: CGFloat
    var percentage: CGFloat
    let onCompletion: () -> Void

    var animatableData: CGFloat {
        get { percentage }
        set { percentage = newValue }
    }

    func body(content: Content) -> some View {
        content.offset(y: percentage * totalDistance)
        let _ = checkIfFinished()
    }

    private func checkIfFinished() {
        if percentage == 1 {
            DispatchQueue.main.async {
                onCompletion()
            }
        }
    }
}

struct InnerCirc:View {
    @Binding public var id:Int
    
    @State public var durationUp:CGFloat
    @State public var durationDown:CGFloat
    @State public var delayUp:CGFloat
    @State public var delayDown:CGFloat
    @State private var percentage = 0.0
    @State private var color:Color = .blue
    
    var body: some View {
        Circle().fill(color).frame(width:50)
        .onAppear()
        {
            withAnimation(.easeIn(duration:durationUp).delay(id == 0 ? 0 : delayUp)){
                percentage = 1
            } completion: {
                withAnimation(.easeIn(duration:durationDown).delay(delayDown)) {
                    percentage = 0
                }completion: {
                    id += 1
                    if(id > 6)
                    {
                        id = 1
                    }
                    
                    print("escond \(id) durUp: \(durationUp) durdown: \(durationDown) delayup: \(delayUp) delaydown \(delayDown) ")
                }
            }
        }
        .offset(y: percentage * -350)
    }
}

struct ResetCirc: View {
    @State private var sz: CGFloat = 80
    @State private var moveUp:Bool = false
    @State private var moveDown:Bool = false
    @State private var color_change:Bool = false
    @State private var color:Color = .blue
    @State private var offset = 0.0
    @State private var viewID = 0
    @State public var durationUp:CGFloat
    @State public var durationDown:CGFloat
    @State public var delayUp:CGFloat
    @State public var delayDown:CGFloat
    
    @State private var percentage = 0.0
    
    var body: some View {
        ZStack
        {
            /*Circle().fill(color)
                .animation(.easeIn(duration:6-duration),
                           value:color)
                .frame(width:100)
                .offset(y:moveUp ? -175 : 175)
                .animation(.easeInOut(duration:0.1).repeatForever(autoreverses: true),
                           value:moveUp)
            */
            
            InnerCirc(id:self.$viewID, durationUp:self.durationUp,
                      durationDown:self.durationDown,
                      delayUp:self.delayUp,
                      delayDown:self.delayDown).id(viewID)
            /*
                //.animation(.easeIn(duration:6-duration).delay(4).repeatForever(autoreverses: true), value:color)
                .frame(width:100)
                .offset(y:moveUp ? 0 : 175)
                .animation(.easeOut(duration:6-duration).delay(0.1).repeatForever(),
                        value:moveUp)
                .offset(y:moveDown ? 0 : -175)
                .animation(.easeOut(duration:6-duration).delay(0.1).repeatForever(),
                        value:moveDown)*/
        }
        .onAppear()
        {
            color = getRandomColor()
            moveUp = true
            moveDown = true
        }
    }
    
    func getRandomColor()->Color
    {
        let r = Double.random(in: 0...1)
        let g = Double.random(in: 0...1)
        let b = Double.random(in: 0...1)
        
        return Color(red:r, green:g, blue:b)
    }
}

struct AnimationLearner: View {
    
    @State private var duration:CGFloat = 2.0
    @State private var viewID = 0
    
    @State public var durationUp:CGFloat
    @State public var durationDown:CGFloat
    @State public var delayUp:CGFloat
    @State public var delayDown:CGFloat
    
    var body: some View {
        VStack{
            ResetCirc(durationUp:self.duration,
                      durationDown:self.duration,
                      delayUp:self.delayUp,
                      delayDown:self.delayDown).id(viewID)
            
            Slider(value:$duration, in:0...4)
            Text("Duration: \(5-duration)")
        }
        .onChange(of: duration)
        {
            viewID += 1
        }
    }
    
    
}

#Preview {
    AnimationLearner(durationUp:1,durationDown:2,delayUp:2,delayDown:6)
}
