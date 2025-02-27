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
    @State private var user: User = GlobalUser.shared.user
    @State private var newUserSheet = false
    @State private var logInSheet = false
    @State private var showView = false
    @State private var showContent = false
    
    @State private var showDetails = false

    // Add this property
    private let signInCoordinator = SignInCoordinator()

    var body: some View
    {
        ZStack {
            if showContent {
                // We can directly use the user since it's non-optional now
                ContentView(user: user)
            } else {
                // Show loading animation
                LoadingAnimation()
                    .onAppear {
                        // Add any initialization logic here
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showContent = true
                        }
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

