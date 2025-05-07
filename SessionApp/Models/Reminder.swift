import Foundation
import SwiftData

@Model
final class Reminder {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isComplete: Bool
    var ekReminderIdentifier: String? // Store EventKit reminder identifier
    
    init(title: String, timestamp: Date = .now, isCritical: Bool = false, isComplete: Bool = false, ekReminderIdentifier: String? = nil) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isComplete = isComplete
        self.ekReminderIdentifier = ekReminderIdentifier
    }
} 
