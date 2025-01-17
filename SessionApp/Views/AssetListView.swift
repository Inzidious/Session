//
//  AssetListView.swift
//  SessionApp
//
//  Created by Shawn McLean on 9/26/24.
//

import SwiftUI

struct AssetListView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View 
    {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Cancel"){ dismiss()}
    }
}

#Preview {
    AssetListView()
}
