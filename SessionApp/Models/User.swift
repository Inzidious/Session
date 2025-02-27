import Foundation
import SwiftData

@Model
final class User {
    // Core identity
    @Attribute(.unique) var id: String  // OAuth ID or generated UUID
    var email: String
    var firstName: String?
    var lastName: String?
    var authProvider: String // "apple", "google", or "email"
    
    // Profile data
    var location: String?
    
    // Note: SwiftData doesn't directly support [String: Any], so we'll need to handle preferences differently
    // Consider using a separate Preferences model or storing as JSON string
    var preferences: String? // Store as JSON string
    
    // Relationships
    @Relationship
    var sessions: [SessionEntry]?
    
    @Relationship(deleteRule: .cascade, inverse: \FeelingEntry.user)
    var feelings: [FeelingEntry]?
    
   @Relationship
   var journalEntries: [JournalEntry]?
    
    // Notification preferences
    var notificationsEnabled: Bool = false
    var homescreenNotificationsEnabled: Bool = false
    
    init(id: String, email: String, firstName: String? = nil, lastName: String? = nil, authProvider: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.authProvider = authProvider
    }
} 
