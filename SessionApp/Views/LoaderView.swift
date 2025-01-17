//
//  LoaderView.swift
//  SessionApp
//
//  Created by Shawn McLean on 10/7/24.
//

import SwiftUI
import SwiftData

struct LoaderView: View 
{
    @Environment(\.modelContext) var context;
    @Query var userList:[User]
    @Query var currentUserList:[CurrentUser]
    @State private var currentUser:CurrentUser? = nil
    @State private var newUserSheet:Bool = false;
    @State private var logInSheet:Bool = false;
    @State private var showView:Bool = false;
    @State private var showContent:Bool = false
    
    @State private var showDetails = false

    var body: some View
    {
        if(showContent == true)
        {
            if let unwr = self.currentUser
            {
                let _ = print("showing content")
                ContentView()
            }
            else
            {
                // no current user, cant shwo content
                let _ = print("no current user, cant shwo content")
            }
        }
        else
        {
            ZStack
            {
                Rectangle().fill(Color("BGRev1")).ignoresSafeArea()
                
                VStack
                {
                    Image("res_therapy")
                    
                    Spacer().frame(maxHeight:600)
                    
                    VStack(spacing:8)
                    {
                        Button()
                        {
                            newUserSheet = true
                        }
                        label:
                        {
                            ZStack
                            {
                                Rectangle()
                                    .frame(maxWidth:.infinity, maxHeight:50)
                                    .foregroundColor(Color(.black).opacity(1))
                                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                    .padding(.horizontal, 20)
                                
                                Text("Sign Up").font(Font.custom("Roboto", size:25)).foregroundColor(.white)
                            }
                        }
                        
                        Spacer().frame(maxHeight:0)
                        
                        if(self.userList.count > 0)
                        {
                            Button()
                            {
                                //let tempUser = User(firstName:"Temp", lastName:"Temp", email:"Test@test.com", password: "test")
                                
                                //context.insert(tempUser)
                                //try! context.save()
                                logInSheet = true
                            }
                            label:
                            {
                                ZStack
                                {
                                    Rectangle()
                                        .frame(maxWidth:.infinity, maxHeight:50)
                                        .foregroundColor(Color(.white).opacity(0.1))
                                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                                        .padding(.horizontal, 20)
                                    
                                    Text("Log In").font(Font.custom("Papyrus", size:25)).foregroundColor(.black)
                                }
                            }
                        }
                        else
                        {
                            Spacer().frame(maxHeight:50)
                        }
                        Spacer().frame(height:20)
                    }
                }
            }.sheet(isPresented: $logInSheet)
            {
                LogInView(currentUser:$currentUser, confirmed:$showContent)
            }.sheet(isPresented: $newUserSheet)
            {
                NewUserView(currentUser:$currentUser, confirmed:$showContent)
            }.onAppear()
            {
                //var _ = print("before")
                
                if(currentUserList.count == 0)
                {
                    //  No Login detected, show prompt
                    //var _ = print("sprompt")
                    //showSplash = true
                    //newUserSheet = true
                }
                else
                {
                    //  For now, log out user each time
                    //  Eventually we set showContent = true
                    currentUser = currentUserList[0]
                    //context.delete(currentUserList[0])
                    showContent = true
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SessionEntry.self, FeelingEntry.self, User.self, CurrentUser.self, configurations: config)
    
    return LoaderView().modelContainer(container)
}
