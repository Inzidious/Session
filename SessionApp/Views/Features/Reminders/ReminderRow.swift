import SwiftUI
import SwiftData

struct ReminderRow: View {
    let reminder: Reminder
    let context: ModelContext
    @Binding var reminderToEdit: Reminder?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if reminder.isCritical {
                    Image(systemName: "exclamationmark.3")
                        .symbolVariant(.fill)
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .bold()
                }
                
                Text(reminder.title)
                    .font(.system(size: 20))
                    .bold()
                Text(reminder.timestamp, format: .dateTime.day().month().year().hour().minute())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            HStack {
                Button {
                    withAnimation {
                        reminder.isCritical.toggle()
                    }
                } label: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(reminder.isCritical ? .red : .gray)
                        .font(.title2)
                }
                .buttonStyle(.plain)
                
                Button {
                    withAnimation {
                        reminder.isComplete.toggle()
                    }
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(reminder.isComplete ? .green : .gray)
                        .font(.largeTitle)
                }
                .buttonStyle(.plain)
            }
        }
        .swipeActions {
            Button(role: .destructive) {
                withAnimation {
                    context.delete(reminder)
                }
            } label: {
                Label("Delete", systemImage: "trash")
                    .symbolVariant(.fill)
            }
            
            Button {
                reminderToEdit = reminder
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.orange)
        }
    }
} 