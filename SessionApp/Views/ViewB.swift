//
//  ViewB.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/15/24.
//

import SwiftUI

struct ViewB: View {
    var body: some View {
        ZStack{
            Color.blue
            
            Image(systemName: "person.2.fill")
                .foregroundColor(.white)
                .font(.system(size:100.0))
        }
    }
}

#Preview {
    ViewB()
}
