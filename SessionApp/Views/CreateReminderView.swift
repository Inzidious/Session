import SwiftUI
import SwiftData
import EventKit

struct CreateReminderView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var timestamp = Date()
    @State private var isCritical = false
    
    private let eventStore = EKEventStore()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    DatePicker("Time", selection: $timestamp)
                    Toggle("Critical", isOn: $isCritical)
                }
            }
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveReminder()
                    }
                }
            }
        }
    }
    
    private func saveReminder() {
        // Create and save the SwiftData reminder
        let reminder = Reminder(
            title: title,
            timestamp: timestamp,
            isCritical: isCritical
        )
        
        // Create the EventKit reminder
        let ekReminder = EKReminder(eventStore: eventStore)
        ekReminder.title = title
        ekReminder.priority = isCritical ? 1 : 0
        ekReminder.calendar = eventStore.defaultCalendarForNewReminders()
        
        do {
            try eventStore.save(ekReminder, commit: true)
            // Store the EventKit reminder identifier
            reminder.ekReminderIdentifier = ekReminder.calendarItemIdentifier
            modelContext.insert(reminder)
            dismiss()
        } catch {
            print("Error saving reminder: \(error)")
            // Handle error appropriately
        }
    }
} 