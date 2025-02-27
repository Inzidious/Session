import SwiftUI
import SwiftData
import AuthenticationServices

struct AuthenticationView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    // State for handling authentication flow
    @State private var showEmailSignIn = false
    @State private var authError: Error?
    @State private var showError = false
    @State private var showTerms = false
    @State private var showPrivacy = false
    @State private var showGuestAlert = false
    
    // User state management
    @State private var currentUser: User?
    @State private var isAuthenticated = false
    
    var body: some View {
        ZStack {
            // Background
            Color("BGRev1").ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                // App logo
                Image("res_therapy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.bottom, 40)
                
                // Sign in with Apple button
                SignInWithAppleButton { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    handleSignInWithAppleResult(result)
                }
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .padding(.horizontal, 20)
                
                // Google Sign in button
                Button {
                    // Implement Google Sign In
                } label: {
                    HStack {
                        Image("google_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Sign in with Google")
                            .font(.body.weight(.medium))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.horizontal, 20)
                
                // Email sign in
                Button {
                    showEmailSignIn = true
                } label: {
                    Text("Sign in with Email")
                        .font(.body.weight(.medium))
                        .foregroundColor(.primary)
                }
                .padding(.top)
                
                // Continue as Guest button
                Button {
                    showGuestAlert = true
                } label: {
                    Text("Continue As Guest")
                        .font(.body.weight(.medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
                // Terms and Privacy
                VStack(spacing: 4) {
                    Text("By continuing, you agree to our")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack(spacing: 4) {
                        Button("Terms of Service") { showTerms = true }
                            .foregroundColor(.blue)
                        Text("and")
                        Button("Privacy Policy") { showPrivacy = true }
                            .foregroundColor(.blue)
                    }
                    .font(.caption)
                }
                .padding(.bottom, 20)
            }
        }
        .alert("Continue as Guest?", isPresented: $showGuestAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Continue with Demo Data") {
                createDemoUser()
            }
            Button("Continue as New Guest") {
                createGuestUser()
            }
        } message: {
            Text("Choose how you would like to continue")
        }
        .sheet(isPresented: $showEmailSignIn) {
            EmailSignInView(isAuthenticated: $isAuthenticated)
        }
        .sheet(isPresented: $showTerms) {
            TermsAndConditionsView()
        }
        .sheet(isPresented: $showPrivacy) {
            PrivacyPolicyView()
        }
    }
    
    private func createDemoUser() {
        DemoDataLoader.loadDemoUser(context: context)
        isAuthenticated = true
        dismiss()
    }
    
    private func createGuestUser() {
        let guestUser = User(
            id: "guest_" + UUID().uuidString,
            email: "guest@example.com",
            firstName: "Guest",
            lastName: "User",
            authProvider: "guest"
        )
        
        currentUser = guestUser
        GlobalUser.shared.user = guestUser
        
        context.insert(guestUser)
        try? context.save()
        
        isAuthenticated = true
        dismiss()
    }
    
    private func handleSignInWithAppleResult(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let newUser = User(
                    id: appleIDCredential.user,
                    email: appleIDCredential.email ?? "",
                    firstName: appleIDCredential.fullName?.givenName,
                    lastName: appleIDCredential.fullName?.familyName,
                    authProvider: "apple"
                )
                
                currentUser = newUser
                GlobalUser.shared.user = newUser
                
                context.insert(newUser)
                try? context.save()
                
                isAuthenticated = true
                dismiss()
            }
        case .failure(let error):
            authError = error
            showError = true
        }
    }
}

#Preview {
    AuthenticationView()
        .modelContainer(for: User.self)
} 