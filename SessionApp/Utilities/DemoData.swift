import Foundation

struct DemoJournalEntry: Codable {
    let promptId: Int
    let promptAnswer: String
    let date: Date
    let sessionID: String  // We'll convert this to UUID when creating the actual entry
    
    enum CodingKeys: CodingKey {
        case promptId, promptAnswer, sessionEntry, timestamp, sessionID
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.sessionID = UUID().uuidString
        self.promptId = try container.decode(Int.self, forKey: .promptId)
        self.promptAnswer = try container.decode(String.self, forKey: .promptAnswer)
        self.date = try container.decode(Date.self, forKey: .timestamp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.sessionID, forKey: .sessionID)
        try container.encode(self.promptId, forKey: .promptId)
        try container.encode(self.promptAnswer, forKey: .promptAnswer)
        try container.encode(self.date, forKey: .timestamp)
    }
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
    
    enum CodingKeys: CodingKey {
        case name,feelingID,sleep,food,move,irrit,cycle,medi,feeling,triggers, timestamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.feeling = try container.decode(String.self, forKey: .name)
        self.sleep = try container.decode(Int.self, forKey: .sleep)
        self.food = try container.decode(Int.self, forKey: .food)
        self.move = try container.decode(Int.self, forKey: .move)
        self.irrit = try container.decode(Int.self, forKey: .irrit)
        self.notes = try container.decode(String.self, forKey: .triggers)
        self.cycle = try container.decode(Int.self, forKey: .cycle)
        self.medi = try container.decode(Int.self, forKey: .medi)
        self.intensity = try container.decode(Int.self, forKey: .feeling)
        self.date = try container.decode(Date.self, forKey: .timestamp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.feeling, forKey: .name)
        try container.encode(self.sleep, forKey: .sleep)
        try container.encode(self.food, forKey: .food)
        try container.encode(self.move, forKey: .move)
        try container.encode(self.irrit, forKey: .irrit)
        try container.encode(self.notes, forKey: .triggers)
        try container.encode(self.cycle, forKey: .cycle)
        try container.encode(self.medi, forKey: .medi)
        try container.encode(self.intensity, forKey: .feeling)
        try container.encode(self.date, forKey: .timestamp)
    }
}

struct DemoNotification: Codable {
    let title: String
    let body: String
    let scheduledDate: Date
    let type: String // "journal", "meditation", etc.
    
    enum CodingKeys: CodingKey {
        case title, body, scheduledDate, type
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
        self.scheduledDate = .now //try container.Date(<#T##value: StringProtocol##StringProtocol#>, strategy: .iso8601)
        self.type = try container.decode(String.self, forKey: .type)
    }
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
