//
//  ViewA.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/15/24.
//

import SwiftUI

struct ViewA: View {
    var body: some View {
        ZStack{
            Color.green
            
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white)
                .font(.system(size:100.0))
        }
    }
}

#Preview {
    ViewA()
}
