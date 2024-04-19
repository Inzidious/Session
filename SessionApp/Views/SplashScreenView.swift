//
//  SplashScreenView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/3/24.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive:Bool = false;
    @State private var size = 0.8;
    @State private var opacity = 0.5;
    
    var body: some View {
        if(isActive)
        {
            ContentView()
        }
        else
        {
            VStack
            {
                VStack
                {
                    Image(systemName: "hare.fill")
                        .font(.system(size:80))
                    
                    Text("Hello again, Shauna!")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear
                {
                    withAnimation(.easeIn(duration: 1.2))
                    {
                        self.size = 1.2;
                        self.opacity = 1.0;
                    }
                }
            }
            .onAppear
            {
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0)
                {
                    self.isActive = true;
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
