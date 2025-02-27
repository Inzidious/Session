import Foundation
import SwiftData

class DemoDataLoader {
    static func loadDemoUser(context: ModelContext) {
        guard let url = Bundle.main.url(forResource: "demo_user", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let demoUser = try? JSONDecoder().decode(DemoUser.self, from: data) else {
            print("Failed to load demo data")
            return
        }
        
        // Create user
        let user = User(
            id: "demo_" + UUID().uuidString,
            email: demoUser.email,
            firstName: demoUser.firstName,
            lastName: demoUser.lastName,
            authProvider: "demo"
        )
        user.location = demoUser.location
        
        // Create journal entries
        for entry in demoUser.journalEntries {
            let journalEntry = JournalEntry(
                promptId: entry.promptId,
                promptAnswer: entry.promptAnswer,
                sessionID: UUID(),
                sessionEntry: nil
            )
            journalEntry.timestamp = entry.date
            
            if user.journalEntries == nil {
                user.journalEntries = []
            }
            user.journalEntries?.append(journalEntry)
        }
        
        // Create feeling entries
        for entry in demoUser.feelingEntries {
            let feelingEntry = FeelingEntry(nameTxt: entry.feeling, user: user)
            // Set additional properties after initialization
            feelingEntry.sleep = entry.sleep ?? 0
            feelingEntry.food = entry.food ?? 0
            feelingEntry.move = entry.move ?? 0
            feelingEntry.irrit = entry.irrit ?? 0
            feelingEntry.cycle = entry.cycle ?? 0
            feelingEntry.medi = entry.medi ?? 0
            feelingEntry.feeling = entry.intensity
            feelingEntry.triggers = entry.notes ?? ""
            feelingEntry.timestamp = entry.date
            
            if user.feelings == nil {
                user.feelings = []
            }
            user.feelings?.append(feelingEntry)
        }
        
        // Save everything
        context.insert(user)
        try? context.save()
        
        // Update GlobalUser
        GlobalUser.shared.user = user
    }
} 
