import SwiftUI
import UserNotifications

struct ProfileView: View {
    // Get the current user from GlobalUser
    private var user: User = GlobalUser.shared.user
    @State private var isEditing = false
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("homescreenNotificationsEnabled") private var homescreenNotificationsEnabled = false
    
    var body: some View {
        NavigationView {
            List {
                // Profile Header
                VStack(spacing: 12) {
                    // Avatar
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                    
                    // Name - using user's actual name
                    Text("\(user.firstName ?? "") \(user.lastName ?? "")")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.gray)
                        Text(user.location ?? "Add Location")
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .padding(.vertical)
                
                // Expandable Personal Information Section
                Section {
                    DisclosureGroup(
                        content: {
                            VStack(alignment: .leading, spacing: 12) {
                                InfoRow(title: "First Name", value: user.firstName ?? "Not set")
                                InfoRow(title: "Last Name", value: user.lastName ?? "Not set")
                                InfoRow(title: "Email", value: user.email)
                                InfoRow(title: "Location", value: user.location ?? "Not set")
                                
                                Button(action: {
                                    isEditing = true
                                }) {
                                    Text("Edit Information")
                                        .foregroundColor(.blue)
                                        .frame(maxWidth: .infinity)
                                        .padding(.top, 8)
                                }
                            }
                            .padding(.vertical, 8)
                        },
                        label: {
                            ProfileMenuRow(icon: "person.fill", title: "Personal Information")
                        }
                    )
                }
                
                // Notifications Section
                Section {
                    DisclosureGroup(
                        content: {
                            VStack(alignment: .leading, spacing: 16) {
                                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                                    .onChange(of: notificationsEnabled) { newValue in
                                        if newValue {
                                            requestNotificationPermission()
                                        }
                                    }
                                
                                if notificationsEnabled {
                                    Toggle("Show on Home Screen", isOn: $homescreenNotificationsEnabled)
                                        .disabled(!notificationsEnabled)
                                }
                                
                                Text("Notifications will be used for:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                                
                                BulletPoint(text: "Journal and meditation reminders")
                                BulletPoint(text: "Session completion notifications")
                                
                                Text("Note: Notifications can be customized in device Settings")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                            }
                            .padding(.vertical, 8)
                        },
                        label: {
                            ProfileMenuRow(icon: "bell.fill", title: "Notifications")
                        }
                    )
                }
                
                // Menu Items
                NavigationLink(destination: Text("Wishlist")) {
                    ProfileMenuRow(icon: "globe", title: "Wishlist")
                }
                
                NavigationLink(destination: Text("Saved")) {
                    ProfileMenuRow(icon: "heart.fill", title: "Saved")
                }
                
                NavigationLink(destination: Text("Settings")) {
                    ProfileMenuRow(icon: "gearshape.fill", title: "Settings")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing: Button(action: {
                // Add edit profile action here
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.primary)
            })
            .sheet(isPresented: $isEditing) {
                NavigationView {
                    PersonalInformationView()
                        .navigationBarItems(leading: Button("Cancel") {
                            isEditing = false
                        })
                }
            }
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if !success {
                // Reset the toggle if permission was denied
                DispatchQueue.main.async {
                    notificationsEnabled = false
                }
            }
        }
    }
}

// Helper view for menu items
struct ProfileMenuRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .frame(width: 24, height: 24)
            Text(title)
        }
        .padding(.vertical, 4)
    }
}

// Helper view for displaying information rows
struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.body)
        }
    }
}

// Helper view for bullet points
struct BulletPoint: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .foregroundColor(.gray)
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

// Add this new RadioButtonGroup component:
struct RadioButtonGroup: View {
    @Binding var selectedOption: String
    let options: [String: String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(options.keys.sorted()), id: \.self) { key in
                Button(action: {
                    selectedOption = key
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: selectedOption == key ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(selectedOption == key ? .blue : .gray)
                        
                        Text(options[key] ?? "")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
