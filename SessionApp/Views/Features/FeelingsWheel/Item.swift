import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var feeling: String
    
    init(timestamp: Date = .now, feeling: String) {
        self.timestamp = timestamp
        self.feeling = feeling
    }
}
