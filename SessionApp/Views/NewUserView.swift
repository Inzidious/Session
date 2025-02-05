//
//  NewUserView.swift
//  SessionApp
//
//  Created by Shawn McLean on 10/7/24.
//

import SwiftUI
import SwiftData

struct NewUserView: View {
    @Environment(\.modelContext) var context;
    @Environment(\.dismiss) private var dismiss
    
    @Binding public var currentUser:CurrentUser?
    @Binding public var confirmed:Bool
    
    @State private var firstName:String = ""
    @State private var lastName:String = ""
    @State private var email:String = ""
    @State private var password:String = ""
    
    init(currentUser:Binding<CurrentUser?>, confirmed:Binding<Bool>)
    {
        self._currentUser = currentUser
        self._confirmed = confirmed
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View
    {
        ZStack
        {
            Rectangle().fill(Color("BGRev1"))
            VStack
            {
                Spacer()
                Text("Welcome Newbie! Let's set up your account.").font(Font.custom("Roboto", size:40)).foregroundColor(.black).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).frame(width:394).padding(12)
                
                Spacer()
                Text("All we need is a few details to get started.").font(Font.custom("Roboto", size:20)).foregroundColor(.black)
                
                Form
                {
                    Section(header: Text("First Name").foregroundColor(.black))
                    {
                        TextField("Required", text:$firstName )
                    }
                    
                    Section(header: Text("Last Name").foregroundColor(.black))
                    {
                        TextField("Required", text:$lastName )
                    }
                    
                    Section(header: Text("Email").foregroundColor(.black))
                    {
                        TextField("Required", text:$email )
                    }
                    
                    Section(header: Text("Password").foregroundColor(.black))
                    {
                        TextField("Required", text:$password)
                    }
                }.scrollContentBackground(.hidden)
                Spacer()
                VStack(spacing:8)
                {
                    Button()
                    {
                        confirmed = true
                        let tempUser = User(firstName:self.firstName, lastName:self.lastName, email:self.email, password: self.password)
                        
                        let tempCurrentUser = CurrentUser(firstName: self.firstName, lastName:self.lastName, email:self.email, password: self.password)
                        
                        currentUser = tempCurrentUser
                        
                        context.insert(tempUser)
                        context.insert(tempCurrentUser)
                        try! context.save()
                        
                        dismiss()
                    }
                    label:
                    {
                        ZStack
                        {
                            Rectangle()
                                .frame(maxWidth:.infinity)
                                .foregroundColor(Color(.black).opacity(0.5))
                                .padding(.horizontal, 20)
                            
                            Text("Sign Up").font(Font.custom("Roboto", size:25)).foregroundColor(.white)
                        }
                    }
                    
                    Button()
                    {
                        dismiss()
                    }
                    label:
                    {
                        ZStack
                        {
                            Rectangle()
                                .frame(maxWidth:.infinity)
                                .foregroundColor(Color(.black).opacity(0.5))
                                .padding(.horizontal, 20)
                            
                            Text("Cancel").font(Font.custom("Roboto", size:25)).foregroundColor(.white)
                        }
                    }
                }.frame(maxHeight:130)
            }
        }
    }
}

struct NewUserPreviewWrapper: View {
    @State private var currentUser: CurrentUser? = nil
    @State private var sel = false
    
    var body: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        if let container = try? ModelContainer(for: SessionEntry.self, 
                                             User.self, 
                                             CurrentUser.self,
                                             configurations: config) {
            NewUserView(currentUser: $currentUser, confirmed: $sel)
                .modelContainer(container)
        } else {
            Text("Failed to create preview container")
        }
    }
}

#Preview {
    NewUserPreviewWrapper()
}
