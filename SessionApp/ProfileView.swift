import SwiftUI

struct ProfileView: View {
    @State private var userName: String = "[Name]"
    @State private var userLocation: String = "Location"
    
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
                    
                    // Name and Location
                    Text(userName)
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Image(systemName: "location.fill")
                            .foregroundColor(.gray)
                        Text(userLocation)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .padding(.vertical)
                
                // Menu Items
                NavigationLink(destination: Text("Personal Information")) {
                    ProfileMenuRow(icon: "person.fill", title: "Personal Information")
                }
                
                NavigationLink(destination: Text("Notifications")) {
                    ProfileMenuRow(icon: "bell.fill", title: "Notifications")
                }
                
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

#Preview {
    ProfileView()
} 