import SwiftUI

struct EmailSignInView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @Binding var currentUser: CurrentUser?
    @Binding var confirmed: Bool
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                        .textContentType(isSignUp ? .newPassword : .password)
                }
                
                if isSignUp {
                    Section("Personal Information") {
                        TextField("First Name", text: $firstName)
                            .textContentType(.givenName)
                        TextField("Last Name", text: $lastName)
                            .textContentType(.familyName)
                    }
                }
                
                Section {
                    Button(isSignUp ? "Create Account" : "Sign In") {
                        handleAuthentication()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle(isSignUp ? "Create Account" : "Sign In")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button(isSignUp ? "Sign In Instead" : "Create Account") {
                    isSignUp.toggle()
                }
            )
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    private func handleAuthentication() {
        // Basic validation
        guard !email.isEmpty else {
            errorMessage = "Please enter an email address"
            showError = true
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Please enter a password"
            showError = true
            return
        }
        
        if isSignUp {
            // Additional signup validation
            guard !firstName.isEmpty else {
                errorMessage = "Please enter your first name"
                showError = true
                return
            }
            
            guard !lastName.isEmpty else {
                errorMessage = "Please enter your last name"
                showError = true
                return
            }
            
            // Create new user
            let newUser = CurrentUser(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password // In a real app, make sure to hash the password
            )
            
            currentUser = newUser
            context.insert(newUser)
            try? context.save()
            confirmed = true
            dismiss()
        } else {
            // Sign in logic
            // In a real app, you would verify against your backend
            // This is just a simple example
            let fetchDescriptor = FetchDescriptor<CurrentUser>(
                predicate: #Predicate<CurrentUser> { user in
                    user.email == email && user.password == password
                }
            )
            
            if let existingUser = try? context.fetch(fetchDescriptor).first {
                currentUser = existingUser
                confirmed = true
                dismiss()
            } else {
                errorMessage = "Invalid email or password"
                showError = true
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CurrentUser.self)
    
    return EmailSignInView(
        currentUser: .constant(nil),
        confirmed: .constant(false)
    )
    .modelContainer(container)
}