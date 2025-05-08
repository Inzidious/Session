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

struct LoaderView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var authManager: AuthManager
    @Query private var users: [User]
    @State private var isLoading = true
    @State private var showError = false
    @State private var errorMessage = ""
    
    // Add signInCoordinator as a property
    private let signInCoordinator = SignInCoordinator()
    
    var body: some View {
        Group {
            if !authManager.isLoggedIn {
                AuthenticationView()
            } else if isLoading {
                // Show loading screen
                VStack {
                    Image("res_therapy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                        .padding()
                }
            } else {
                // Show main content
                ContentView(user: GlobalUser.shared.user)
                    .environmentObject(authManager)
            }
        }
        .onAppear {
            print("AuthManager isLoggedIn:", authManager.isLoggedIn)
        }
        .task {
            do {
                // Initialize GlobalUser if needed
                if users.isEmpty {
                    // Create a default guest user if no users exist
                    let guestUser = User(
                        id: "guest_" + UUID().uuidString,
                        email: "guest@example.com",
                        firstName: "Guest",
                        lastName: "User",
                        authProvider: "guest"
                    )
                    GlobalUser.shared.user = guestUser
                    modelContext.insert(guestUser)
                    try modelContext.save()
                } else {
                    // Use the first user found
                    GlobalUser.shared.user = users[0]
                }
                
                // Simulate loading time
                try await Task.sleep(nanoseconds: 2_000_000_000)
                isLoading = false
            } catch {
                errorMessage = "Failed to load: \(error.localizedDescription)"
                showError = true
            }
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
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

