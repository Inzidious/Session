//
//  LoaderView.swift
//  SessionApp
//
//  Created by Shawn McLean on 10/7/24.
//

import SwiftUI
import SwiftData
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

    // Add this property
    private let signInCoordinator = SignInCoordinator()

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
                        if(self.userList.count > 0) {
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
    let container = try! ModelContainer(for: SessionEntry.self, FeelingEntry.self, User.self, CurrentUser.self, configurations: config)
    
    return LoaderView().modelContainer(container)
}

