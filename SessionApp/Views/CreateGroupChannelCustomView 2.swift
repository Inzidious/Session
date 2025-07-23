import SwiftUI
import SendbirdChatSDK
import SwiftData

struct CreateGroupChannelCustomView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query private var users: [User]
    @State private var selectedUserIds: Set<String> = []
    @State private var channelName: String = ""
    @State private var isCreating: Bool = false
    @State private var errorMessage: String? = nil
    @State private var showSuccess: Bool = false
    @State private var selectedImage: String = "mountain" // Default image
    
    private let availableImages = [
        ("mountain", "https://mytherapymuse.com/wp-content/uploads/2025/06/mountain.png"),
        ("seafoam", "https://mytherapymuse.com/wp-content/uploads/2025/06/seafoam.png"),
        ("greenblue", "https://mytherapymuse.com/wp-content/uploads/2025/06/greenblue.png")
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Channel Name")) {
                    TextField("Enter channel name", text: $channelName)
                }
                
                Section(header: Text("Select Group Image")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(availableImages, id: \.0) { image in
                                Image(image.0)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedImage == image.0 ? Color.blue : Color.clear, lineWidth: 3)
                                    )
                                    .onTapGesture {
                                        selectedImage = image.0
                                    }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                Section {
                    Button(action: createChannel) {
                        if isCreating {
                            ProgressView()
                        } else {
                            Text("Create Channel")
                        }
                    }
                    .disabled(channelName.isEmpty || isCreating)
                }
                if let errorMessage = errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("New Group Channel")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .alert("Channel Created!", isPresented: $showSuccess) {
                Button("OK") { dismiss() }
            }
        }
    }
    
    private func createChannel() {
        isCreating = true
        errorMessage = nil
        let params = GroupChannelCreateParams()
        params.name = channelName
        params.userIds = Array(selectedUserIds)
        params.isPublic = false // or true if you want public
        
        // Get the selected image URL
        let selectedImageUrl = availableImages.first(where: { $0.0 == selectedImage })?.1 ?? ""
        
        // Create custom data dictionary
        let customData: [String: String] = [
            "groupImageUrl": selectedImageUrl,
            "groupName": channelName
        ]
        
        // Convert to JSON string
        if let jsonData = try? JSONSerialization.data(withJSONObject: customData),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            params.data = jsonString
        }
        
        GroupChannel.createChannel(params: params) { channel, error in
            DispatchQueue.main.async {
                isCreating = false
                if let error = error {
                    print("In error: ", error)
                    errorMessage = error.localizedDescription
                } else if let channel = channel {
                    print("Success")
                    // Store the channel URL for sharing
                    shareLink = channel.channelUrl
                    showSuccess = true
                }
            }
        }
    }
}

private struct MultipleSelectionRow: View {
    let user: User
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? .blue : .gray)
                VStack(alignment: .leading) {
                    Text(user.firstName ?? "") + Text(" ") + Text(user.lastName ?? "")
                    Text(user.email).font(.caption).foregroundColor(.secondary)
                }
            }
        }
    }
}

#Preview {
    
    CreateGroupChannelCustomView()
}

