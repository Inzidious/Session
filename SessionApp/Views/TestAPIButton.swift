//
//  TestAPIButton.swift
//  SessionApp
//
//  Created by Shawn McLean on 1/23/25.
//

import SwiftUI

struct TestAPIButton: View {
    @State private var bankUser:BankUser? = nil
    var body: some View {
        Button()
        {
            Task{
                do{
                    print("Here1")
                    try await loadUser()
                } catch {
                    
                }
            }
        }
        label:
        {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
    
    func loadUser() async throws
    {
        do{
            print("Here2")
            try await bankUser = getBankUser()
        } catch {
            print("HereError1")
            throw APIError.invalidData
        }
    }
}

#Preview {
    TestAPIButton()
}
