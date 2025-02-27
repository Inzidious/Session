import SwiftUI

struct PersonalInformationView: View {
    @State private var user: User = GlobalUser.shared.user
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // Local state for editing
    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String
    @State private var city: String
    @State private var state: String
    
    // Initialize state with current user data
    init() {
        let currentUser = GlobalUser.shared.user
        _firstName = State(initialValue: currentUser.firstName ?? "")
        _lastName = State(initialValue: currentUser.lastName ?? "")
        _email = State(initialValue: currentUser.email)
        _city = State(initialValue: currentUser.location?.components(separatedBy: ", ").first ?? "")
        _state = State(initialValue: currentUser.location?.components(separatedBy: ", ").last ?? "")
    }
    
    var body: some View {
        Form {
            Section(header: Text("Basic Information")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            
            Section(header: Text("Location")) {
                TextField("City", text: $city)
                TextField("State", text: $state)
            }
            
            Section {
                Button("Save Changes") {
                    saveChanges()
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.blue)
            }
        }
        .navigationTitle("Personal Information")
    }
    
    private func saveChanges() {
        // Update the user object
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.location = "\(city), \(state)"
        
        // Update GlobalUser
        GlobalUser.shared.user = user
        
        // Save to SwiftData
        try? modelContext.save()
        
        dismiss()
    }
} 