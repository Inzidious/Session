import Foundation
import SwiftData

@Model
final class Reminder {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isComplete: Bool
    
    init(title: String, timestamp: Date = .now, isCritical: Bool = false, isComplete: Bool = false) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isComplete = isComplete
    }
} 
