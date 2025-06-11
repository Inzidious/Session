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
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Channel Name")) {
                    TextField("Enter channel name", text: $channelName)
                }
                /*Section(header: Text("Select Users")) {
                    if users.isEmpty {
                        Text("No users available.")
                    } else {
                        List(users, id: \.id) { user in
                            MultipleSelectionRow(
                                user: user,
                                isSelected: selectedUserIds.contains(user.id)
                            ) {
                                if selectedUserIds.contains(user.id) {
                                    selectedUserIds.remove(user.id)
                                } else {
                                    selectedUserIds.insert(user.id)
                                }
                            }
                        }
                    }
                }*/
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
        GroupChannel.createChannel(params: params) { channel, error in
            DispatchQueue.main.async {
                isCreating = false
                if let error = error {
                    print("In error: ", error)
                    errorMessage = error.localizedDescription
                } else {
                    print("Success")
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

