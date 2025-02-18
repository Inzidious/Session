import SwiftUI
import AuthenticationServices

struct AuthenticationView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @Binding var user: User?
    @Binding var confirmed: Bool
    
    // State for handling authentication flow
    @State private var showEmailSignIn = false
    @State private var authError: Error?
    @State private var showError = false
    
    var body: some View {
        ZStack {
            // Background
            Color("BGRev1").ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                // App logo/branding
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
                        Image("google_logo") // Add this asset
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
                
                // Email sign in option
                Button {
                    showEmailSignIn = true
                } label: {
                    Text("Sign in with Email")
                        .font(.body.weight(.medium))
                        .foregroundColor(.primary)
                }
                .padding(.top)
                
                Spacer()
                
                // Terms and Privacy
                VStack(spacing: 4) {
                    Text("By continuing, you agree to our")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    HStack(spacing: 4) {
                        Link("Terms of Service", destination: URL(string: "https://your-terms-url.com")!)
                        Text("and")
                        Link("Privacy Policy", destination: URL(string: "https://your-privacy-url.com")!)
                    }
                    .font(.caption)
                }
                .padding(.bottom, 20)
            }
        }
        .sheet(isPresented: $showEmailSignIn) {
            EmailSignInView(user: $user, confirmed: $confirmed)
        }
        .alert("Authentication Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(authError?.localizedDescription ?? "An unknown error occurred")
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
            }.frame(height:50)
        }
    }
    
    private func handleSignInWithAppleResult(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                // Handle successful sign in
                let userId = appleIDCredential.user
                let email = appleIDCredential.email
                let firstName = appleIDCredential.fullName?.givenName
                let lastName = appleIDCredential.fullName?.familyName
                
                // Create new User instance - note the capital U
                let newUser = User(
                    id: userId,  // Use the Apple ID as the user ID
                    email: email ?? userId,
                    firstName: firstName,
                    lastName: lastName,
                    authProvider: "apple"  // Indicate this is an Apple sign-in
                )
                
                // Assign to the binding
                user = newUser
                context.insert(newUser)
                try? context.save()
                confirmed = true
                dismiss()
            }
        case .failure(let error):
            authError = error
            showError = true
        }
    }
} 
