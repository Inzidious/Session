import SwiftUI
import SwiftData

struct UpdateReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var reminder: Reminder
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter reminder title", text: $reminder.title)
                Toggle("Critical?", isOn: $reminder.isCritical)
            }
            .navigationTitle("Update Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
} 