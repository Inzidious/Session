//
//  LogInView.swift
//  SessionApp
//
//  Created by Shawn McLean on 10/15/24.
//

import SwiftUI
import SwiftData

struct LogInView: View {
    @Environment(\.modelContext) var context;
    @Environment(\.dismiss) private var dismiss
    
    // gt Users
    @Query var userList:[User]
    
    @Binding public var currentUser:CurrentUser?
    @Binding public var confirmed:Bool
    
    @State private var email:String = ""
    @State private var password:String = ""
    
    @State private var failed:Bool = false
    
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
                Image("res_therapy")
                
                HStack
                {
                    Text("Sign In")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(Font.custom("Roboto", size:30))
                    
                    Spacer().frame(width:230)
                }
                
                Form
                {
                    //TextField("First name", text:$firstName )
                    //TextField("Last name", text:$lastName )
                    Section(header: Text("EMail").foregroundColor(.black))
                    {
                        TextField("name@example", text:$email ).foregroundColor(.black)
                    }
                        
                    Section(header: Text("Password").foregroundColor(.black))
                    {
                        TextField("Password", text:$password)
                    }
                    
                }.scrollContentBackground(.hidden).frame(maxHeight:180)
                
                if(failed)
                {
                    Text("Bad email/password combo")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(Font.custom("Roboto", size:30))
                }
                else
                {
                    Spacer()
                }
                
                Button()
                {
                    var tempUser:CurrentUser? = nil
                    
                    if(userList.count > 0)
                    {
                        for user in self.userList
                        {
                            if(self.email == user.email)
                            {
                                let _ = print("hit: ")
                                tempUser = CurrentUser(firstName:user.firstName, lastName:user.lastName, email:user.email, password: user.password)
                            }
                        }
                    }
                    else
                    {
                        let _ = print("no users")
                    }
                    
                    if(tempUser != nil)
                    {
                        confirmed = true
                        currentUser = tempUser
                     
                        if let unwr = tempUser
                        {
                            context.insert(unwr)
                        }
                        
                        try! context.save()
                        
                        dismiss()
                    }
                    else
                    {
                        self.failed = true
                        let _ = print("No match to email/password")
                    }
                }
                label:
                {
                    ZStack
                    {
                        Rectangle()
                            .frame(maxWidth:.infinity, maxHeight:50)
                            .foregroundColor(Color(.black).opacity(0.5))
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                            .padding(20)
                        
                        Text("Sign In").font(Font.custom("Papyrus", size:25)).foregroundColor(.white)
                    }
                }
                
                Spacer()
            }
        }
    }
}

struct LoginPreviewWrapper: View {
    @State private var currentUser: CurrentUser? = nil
    @State private var sel = false
    
    var body: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        if let container = try? ModelContainer(for: SessionEntry.self, 
                                             User.self, 
                                             CurrentUser.self,
                                             configurations: config) {
            LogInView(currentUser: $currentUser, confirmed: $sel)
                .modelContainer(container)
        } else {
            Text("Failed to create preview container")
        }
    }
}

#Preview {
    LoginPreviewWrapper()
}
