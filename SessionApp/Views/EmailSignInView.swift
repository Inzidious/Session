import SwiftUI
import SwiftData


struct EmailSignInView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var authManager: AuthManager
    @Binding var isAuthenticated: Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        // Break complex view hierarchies into smaller components
        VStack {
            // Extract form fields into separate view
            EmailSignInFormFields(
                email: $email,
                password: $password
            )
            
            // Extract button into separate view
            SignInButton(
                email: email,
                password: password,
                onSignIn: handleSignIn
            )
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
    
    // Break complex functions into smaller parts
    private func handleSignIn() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            showError = true
            return
        }
        
        // Create user and handle sign in
        let newUser = User(
            id: UUID().uuidString,
            email: email,
            firstName: nil,
            lastName: nil,
            authProvider: "email"
        )
        
        GlobalUser.shared.user = newUser
        context.insert(newUser)
        try? context.save()
        
        authManager.isLoggedIn = true
        isAuthenticated = true
        dismiss()
    }
}

// Break out into separate views
struct EmailSignInFormFields: View {
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}

struct SignInButton: View {
    let email: String
    let password: String
    let onSignIn: () -> Void
    
    var body: some View {
        Button("Sign In") {
            onSignIn()
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: User.self,
        configurations:config
        )
    
    //return EmailSignInView(user: .constant(nil))
    //    .modelContainer(container)
    //    confirmed: .constant(false)
    
    
}
