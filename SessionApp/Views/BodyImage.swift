//
//  BodyImage.swift
//  SessionApp
//
//  Created by Shawn McLean on 11/19/24.
//

import SwiftUI
import Observation

struct BodyImage: View 
{
    @Environment(\.dismiss) private var dismiss
    
    @Binding public var bodyvalue:String
    
    var body: some View
    {
        Image("body_picker").resizable()
            .onTapGesture
            { location in
                print("X: \(location.x) Y: \(location.y)")
                // Arm 1
                if(location.x > 23 && location.x < 114 && location.y > 157 && location.y < 405)
                {
                    bodyvalue = "L Arm"
                    dismiss()
                    print("Arm 1: \(location.x) Y: \(location.y)")
                }
                else if(location.x > 276 && location.x < 358 && location.y > 157 && location.y < 405)
                {
                    bodyvalue = "R Arm"
                    dismiss()
                    print("Arm 2: \(location.x) Y: \(location.y)")
                }
                else if(location.x > 117 && location.x < 192 && location.y > 392 && location.y < 743)
                {
                    bodyvalue = "L Leg"
                    dismiss()
                    print("Leg 1: \(location.x) Y: \(location.y)")
                }
                else if(location.x > 215 && location.x < 276 && location.y > 392 && location.y < 743)
                {
                    bodyvalue = "R Leg"
                    dismiss()
                    print("Leg 2: \(location.x) Y: \(location.y)")
                }
                else if(location.x > 122 && location.x < 270 && location.y > 137 && location.y < 387)
                {
                    bodyvalue = "Body"
                    dismiss()
                    print("Body: \(location.x) Y: \(location.y)")
                }
                else if(location.x > 143 && location.x < 260 && location.y > 10 && location.y < 122)
                {
                    bodyvalue = "Head"
                    dismiss()
                    print("Head: \(location.x) Y: \(location.y)")
                }
            }
        
        
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var temp = ""
        
        var body: some View {
            BodyImage(bodyvalue: $temp)
        }
    }
    
    return PreviewWrapper()
}
