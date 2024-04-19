//
//  EditorView.swift
//  SessionApp
//
//  Created by Shawn McLean on 4/3/24.
//

import SwiftUI

struct EditorView: View {
    @State private var inputText = "Start writing...";
    
    @State private var isActive = false;
    var myColor = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1));
    
    var body: some View
    {
        ZStack
        {
            Rectangle().fill(Color("BGColor")).ignoresSafeArea()
            
            VStack
            {
                TextField("Start writing...", text: $inputText)
                    .font(.title)
                    .lineSpacing(20)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                    .padding()
                    .colorMultiply(myColor)
                    .frame(width:380, height:310)
                    .background(Color.white)
                    .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Button("Click me!") {
                                            print("Clicked")
                                        }
                                    }
                                }
            
            }.padding()
        }
    }
}

#Preview {
    EditorView()
}
