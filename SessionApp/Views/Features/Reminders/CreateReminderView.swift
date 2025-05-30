import SwiftUI
import SwiftData
import EventKit
import PhotosUI

struct CreateReminderView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var isSaving = false
    @State private var title = ""
    @State private var timestamp = Date()
    @State private var isCritical = false
    @State private var showingDatePicker = false
    @State private var showingLocationPicker = false
    @State private var showingPhotoPicker = false
    @State private var selectedImage: UIImage?
    
    @State private var hashtags: [String] = []
    @State private var location: String?
    
    private let eventStore = EKEventStore()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ReminderTextField(
                        text: $title,
                        placeholder: "Title",
                        onDateTap: { showingDatePicker = true },
                        onLocationTap: { showingLocationPicker = true },
                        onHashtagTap: { addHashtag() },
                        onFlagTap: { isCritical.toggle() },
                        onPhotoTap: { showingPhotoPicker = true }
                    )
                    .frame(height: 44)
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    DatePicker("Time", selection: $timestamp)
                    Toggle("Critical", isOn: $isCritical)
                }
                
                if !hashtags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(hashtags, id: \.self) { tag in
                                Text(tag)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                
                if let location = location {
                    HStack {
                        Image(systemName: "location.fill")
                        Text(location)
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                                .font(.title2)
                                .foregroundColor(Color(red: 0.882, green: 0.694, blue: 0.416))
                                .scaleEffect(1.25)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        Task {
                            isSaving = true
                            do {
                                try await saveReminder()
                                hapticFeedback(.success)
                                // Dismiss after a brief delay to show success state
                                try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
                                dismiss()
                            } catch {
                                print("Error saving reminder: \(error)")
                                hapticFeedback(.error)
                                // TODO: Show error alert to user
                            }
                            isSaving = false
                        }
                    }) {
                        if isSaving {
                            ProgressView()
                                .controlSize(.small)
                        } else {
                            Text("Save")
                        }
                    }
                    .disabled(isSaving || title.isEmpty)
                }
            }
            .sheet(isPresented: $showingDatePicker) {
                DatePicker("Select Date", selection: $timestamp)
                    .datePickerStyle(.graphical)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showingLocationPicker) {
                Text("Location Picker - To be implemented")
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showingPhotoPicker) {
                PhotoPickerView(selectedImage: $selectedImage)
                    .presentationDetents([.medium])
            }
        }
    }
    
    private func hapticFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    private func saveReminder() async throws {
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
        
        // Add location if available
        if let location = location {
            ekReminder.location = location
        }
        
        // Add notes with hashtags
        if !hashtags.isEmpty {
            ekReminder.notes = hashtags.joined(separator: " ")
        }
        
        try eventStore.save(ekReminder, commit: true)
        reminder.ekReminderIdentifier = ekReminder.calendarItemIdentifier
        modelContext.insert(reminder)
    }
    
    private func addHashtag() {
        let hashtag = "#reminder\(hashtags.count + 1)"
        hashtags.append(hashtag)
    }
} 
