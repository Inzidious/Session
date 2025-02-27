import Foundation

struct DemoJournalEntry: Codable {
    let promptId: Int
    let promptAnswer: String
    let date: Date
    let sessionID: String  // We'll convert this to UUID when creating the actual entry
}

struct DemoFeelingEntry: Codable {
    let feeling: String    // This will be used as the name parameter
    let intensity: Int
    let date: Date
    let notes: String?
    // Add optional fields to match FeelingEntry model
    let sleep: Int?
    let food: Int?
    let move: Int?
    let irrit: Int?
    let cycle: Int?
    let medi: Int?
}

struct DemoNotification: Codable {
    let title: String
    let body: String
    let scheduledDate: Date
    let type: String // "journal", "meditation", etc.
}

struct DemoUser: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let location: String
    let journalEntries: [DemoJournalEntry]
    let feelingEntries: [DemoFeelingEntry]
    let notifications: [DemoNotification]
} 