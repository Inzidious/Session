import SwiftUI
import SwiftData
import EventKit

struct UpdateReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var reminder: Reminder
    
    private let eventStore = EKEventStore()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $reminder.title)
                    DatePicker("Time", selection: $reminder.timestamp)
                    Toggle("Critical", isOn: $reminder.isCritical)
                }
            }
            .navigationTitle("Edit Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        updateReminder()
                    }
                }
            }
        }
    }
    
    private func updateReminder() {
        // If we have an EventKit identifier, update the system reminder
        if let ekIdentifier = reminder.ekReminderIdentifier {
            let predicate = eventStore.predicateForReminders(in: nil)
            
            eventStore.fetchReminders(matching: predicate) { ekReminders in
                guard let ekReminders = ekReminders else { return }
                
                // Find the matching EventKit reminder
                if let ekReminder = ekReminders.first(where: { $0.calendarItemIdentifier == ekIdentifier }) {
                    // Update the EventKit reminder
                    ekReminder.title = reminder.title
                    ekReminder.priority = reminder.isCritical ? 1 : 0
                    
                    do {
                        try eventStore.save(ekReminder, commit: true)
                    } catch {
                        print("Error updating EventKit reminder: \(error)")
                        // Handle error appropriately
                    }
                }
            }
        }
        
        dismiss()
    }
} 