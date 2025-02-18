//
//  LoaderView.swift
//  SessionApp
//
//  Created by Shawn McLean on 10/7/24.
//

import SwiftUI
import SwiftData
// import User

import AuthenticationServices // For Apple Sign In
// import GoogleSignIn // For Google Sign In
// import GoogleSignInSwift  // Add this import

// Add this class before the LoaderView struct
class SignInCoordinator: NSObject, ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // Handle the successful sign-in
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Sign In failed: \(error.localizedDescription)")
    }
}
    
    // References to user data
    var sessions: [SessionEntry]?
    var feelings: [FeelingEntry]?
    var journalEntries: [JournalEntry]?

struct LoaderView: View 
{
    @Environment(\.modelContext) var modelContext
    @Query private var users: [User]
    @State private var user: User?
    @State private var newUserSheet = false
    @State private var logInSheet = false
    @State private var showView = false
    @State private var showContent = false
    
    @State private var showDetails = false

    // Add this property
    private let signInCoordinator = SignInCoordinator()

    var body: some View
    {
        if(showContent == true)
        {
            if let currentUser = user
            {
                let _ = print("showing content")
                ContentView(user: currentUser)
            }
            else
            {
                // no current user, cant shwo content
                let _ = print("no current user, cant show content")
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
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        .frame(maxHeight: UIScreen.main.bounds.height * 0.3)
                        .padding(.top, 40)
                    
                    Spacer().frame(maxHeight: 40)
                    
                    VStack(spacing:8)
                    {
                        // Apple Sign In Button
                        Button() {
                            // Handle Apple Sign In
                            handleAppleSignIn()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Image(systemName: "apple.logo")
                                        .foregroundColor(.white)
                                    Text("Continue with Apple")
                                        .font(Font.custom("Roboto", size: 20))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        // Google Sign In Button
                        Button() {
                            // Handle Google Sign In
                            handleGoogleSignIn()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .foregroundColor(.white)
                                    .border(Color.gray)
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Image("google_logo") // You'll need to add this asset
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text("Continue with Google")
                                        .font(Font.custom("Roboto", size: 20))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                        // Divider with "or" text
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.3))
                            Text("or")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray.opacity(0.3))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        
                        // Existing Email Sign Up Button
                        Button() {
                            newUserSheet = true
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .foregroundColor(Color(.black).opacity(1))
                                    .border(Color.black)
                                    .padding(.horizontal, 20)
                                
                                Text("Sign Up with Email")
                                    .font(Font.custom("Roboto", size: 20))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        // Show Email Login only if users exist
                        if(self.users.count > 0) {
                            Button() {
                                logInSheet = true
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: 50)
                                        .foregroundColor(Color(.white).opacity(0.1))
                                        .border(Color.black)
                                        .padding(.horizontal, 20)
                                    
                                    Text("Log In with Email")
                                        .font(Font.custom("Roboto", size: 20))
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        
                        Spacer().frame(height: 20)
                    }
                }
            }.sheet(isPresented: $logInSheet)
            {
                EmailSignInView(user: $user, confirmed: $showContent)
            }.sheet(isPresented: $newUserSheet)
            {
                EmailSignInView(
                    user: $user,
                    confirmed: $showContent
                )
            }.onAppear()
            {
                //var _ = print("before")
                
                if(users.count == 0)
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
                    user = users[0]
                    //context.delete(userList[0])
                    showContent = true
                }
            }
        }
    }

    private func handleAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = signInCoordinator
        controller.performRequests()
    }

    private func handleGoogleSignIn() {
        // Comment out Google sign in implementation temporarily
        // GIDSignIn.sharedInstance.signIn(
        //     withPresenting: UIApplication.shared.windows.first?.rootViewController ?? UIViewController()
        // ) { signInResult, error in
        //     // Handle sign in result
        // }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: User.self,
        SessionEntry.self,
        FeelingEntry.self,
        JournalEntry.self,
        configurations: config
    )
    
    return LoaderView()
        .modelContainer(container)
}

