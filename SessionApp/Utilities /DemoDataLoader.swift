import Foundation
import SwiftData

class DemoDataLoader {
    static func loadDemoUser(context: ModelContext) {
        guard let url = Bundle.main.url(forResource: "demo_user", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to load demo data")
            return
        }
        
        var demoUser:DemoUser!
        
        do{
            demoUser = try JSONDecoder().decode(DemoUser.self, from: data)
        } catch let jsonError as NSError {
            //print("really?")
            print("JSON decode failed: \(jsonError)")
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
        context.insert(user)
        
        // Create journal entries
        for entry in demoUser.journalEntries {
            let journalEntry = JournalEntry(
                promptId: entry.promptId,
                promptAnswer: entry.promptAnswer,
                sessionID: UUID(),
                sessionEntry: nil
            )
            journalEntry.timestamp = entry.date
            journalEntry.user = user
            
            context.insert(journalEntry)
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
            
            feelingEntry.user = user
            
            context.insert(feelingEntry)
        }
        
        // Save everything
        //context.insert(user)
        try? context.save()
        
        print("made it")
        
        // Update GlobalUser
        GlobalUser.shared.user = user
    }
} 
