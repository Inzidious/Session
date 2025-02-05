//
//  ViewA.swift
//  SessionApp
//
//  Created by Shawn McLean on 3/15/24.
//

import SwiftUI
import SwiftData

struct ViewA: View {
    private let adaptiveColumns = [GridItem(.adaptive(minimum:sqsize))]
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                Spacer()
                HStack
                {
                    Spacer().frame(width:110)
                    
                    Text("Resources")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.openSansSemiBold(size: 38))
                }
                Spacer()
                LazyVGrid(columns:adaptiveColumns,
                          spacing:30)
                {
                    /*smallBoxStack()
                     smallBoxStack(boxText: "Breath")
                     smallBoxStack(boxText: "Meditation")
                     smallBoxStack(boxText: "Focus")*/
                    
                    smallBoxImage(boxText: "res_feeelings").padding(.leading, 50)
        
                    Spacer()
                    
                    smallBoxImage(boxText: "res_problem").padding(.trailing, 50)
                    
                    smallBoxImage(boxText: "res_stress").padding(.leading, 50)
                    Spacer()
                    
                    NavigationLink(destination:ResourceDetails())
                    {
                        smallBoxImage(boxText: "res_dep").padding(.trailing, 50)
                    }
                    
                    smallBoxImage(boxText: "res_comm").padding(.leading, 50)
                    Spacer().frame(width: 5)
                    smallBoxImage(boxText: "res_anxiety").padding(.trailing, 50)
                    
                    smallBoxImage(boxText: "res_grief").padding(.leading, 50)
                    Spacer().frame(width: 5)
                    smallBoxImage(boxText: "res_anger").padding(.trailing, 50)
                    
                    
                }
                .padding()
                .frame(alignment: .top)
            }
            .onAppear {
                for family in UIFont.familyNames.sorted() {
                    let names = UIFont.fontNames(forFamilyName: family)
                    print("Family: \(family) Font names: \(names)")
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    if let container = try? ModelContainer(for: SessionEntry.self,
                                         FeelingEntry.self,
                                         configurations: config) {
        ViewA()
            .modelContainer(container)
    } else {
        Text("Failed to create container")
    }
}
