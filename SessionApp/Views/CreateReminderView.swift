import SwiftUI
import SwiftData

struct CreateReminderView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var isCritical: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Enter reminder title", text: $title)
                Toggle("Critical?", isOn: $isCritical)
            }
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let reminder = Reminder(title: title, isCritical: isCritical)
                        context.insert(reminder)
                        try? context.save()  // Explicitly save the context
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
} 