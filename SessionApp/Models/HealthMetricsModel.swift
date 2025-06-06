import Foundation
// Data model for the health metrics
// Enum for metric categories
enum MetricCategory: String, CaseIterable {
    case sleep = "Sleep"
    case food = "Food"
    case movement = "Movement"
    case irritability = "Irritability"
    case menstrualCycle = "Menstrual Cycle"
    
    var shortDisplayName: String {
        switch self {
        case .sleep: return "Sleep"
        case .food: return "Food"
        case .movement: return "Move"
        case .irritability: return "Irritate"
        case .menstrualCycle: return "MCycle"
        }
    }
}

// Enum for metric levels
enum MetricLevel: Int, CaseIterable, Codable {
    case none = 0
    case low = 1
    case good = 2
    case great = 3
    
    var description: String {
        switch self {
        case .none: return "None"
        case .low: return "Low"
        case .good: return "Good"
        case .great: return "Great"
        }
    }
}

// Struct for individual health metric entry
struct HealthMetricEntry: Identifiable, Codable {
    let id: String
    let date: Date
    let feeling: Int
    let sleep: MetricLevel
    let food: MetricLevel
    let movement: MetricLevel
    let irritability: MetricLevel
    let menstrualCycle: MetricLevel
    let triggers: String
    
    enum CodingKeys: String, CodingKey {
        case id = "feelingID"
        case date = "timestamp"
        case feeling
        case sleep
        case food
        case move
        case irrit
        case cycle
        case triggers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        
        // Convert timestamp to Date
        let timestamp = try container.decode(Double.self, forKey: .date)
        self.date = Date(timeIntervalSince1970: timestamp)
        
        // Decode and convert numeric values to MetricLevel
        let sleepValue = try container.decode(Int.self, forKey: .sleep)
        self.sleep = MetricLevel(rawValue: sleepValue) ?? .none
        
        let foodValue = try container.decode(Int.self, forKey: .food)
        self.food = MetricLevel(rawValue: foodValue) ?? .none
        
        let moveValue = try container.decode(Int.self, forKey: .move)
        self.movement = MetricLevel(rawValue: moveValue) ?? .none
        
        let irritValue = try container.decode(Int.self, forKey: .irrit)
        self.irritability = MetricLevel(rawValue: irritValue) ?? .none
        
        let cycleValue = try container.decode(Int.self, forKey: .cycle)
        self.menstrualCycle = MetricLevel(rawValue: cycleValue) ?? .none
        
        self.feeling = try container.decode(Int.self, forKey: .feeling)
        
        self.triggers = try container.decode(String.self, forKey: .triggers)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(date.timeIntervalSince1970, forKey: .date)
        try container.encode(feeling, forKey: .feeling)
        try container.encode(sleep.rawValue, forKey: .sleep)
        try container.encode(food.rawValue, forKey: .food)
        try container.encode(movement.rawValue, forKey: .move)
        try container.encode(irritability.rawValue, forKey: .irrit)
        try container.encode(menstrualCycle.rawValue, forKey: .cycle)
        try container.encode(triggers, forKey: .triggers)
    }
}

// Class to manage health metrics data
class HealthMetricsManager: ObservableObject {
    @Published var entries: [HealthMetricEntry] = []
    
    init() {
        loadData()
    }
    
    private func loadData() {
        do {
            let decoder = JSONDecoder()
            // Get the JSON string from DATA.swift
            let jsonString = feelingJSONString
            guard let data = jsonString.data(using: .utf8) else {
                print("Error converting JSON string to data")
                return
            }
            entries = try decoder.decode([HealthMetricEntry].self, from: data)
            entries.sort { $0.date < $1.date }
        } catch {
            print("Error loading health metrics data: \(error)")
        }
    }
    
    // Get entries for a specific metric category
    func getEntries(for category: MetricCategory) -> [(date: Date, value: MetricLevel)] {
        return entries.map { entry in
            let value: MetricLevel
            switch category {
            case .sleep:
                value = entry.sleep
            case .food:
                value = entry.food
            case .movement:
                value = entry.movement
            case .irritability:
                value = entry.irritability
            case .menstrualCycle:
                value = entry.menstrualCycle
            }
            return (entry.date, value)
        }
    }
    
    // Get entries within a date range
    func getEntries(from startDate: Date, to endDate: Date) -> [HealthMetricEntry] {
        return entries.filter { entry in
            entry.date >= startDate && entry.date <= endDate
        }
    }
    
    // Get entries for a specific metric category and date range
    func getEntries(for category: MetricCategory, from startDate: Date, to endDate: Date) -> [(date: Date, value: MetricLevel)] {
        return entries.filter { $0.date >= startDate && $0.date <= endDate }.map { entry in
            let value: MetricLevel
            switch category {
            case .sleep:
                value = entry.sleep
            case .food:
                value = entry.food
            case .movement:
                value = entry.movement
            case .irritability:
                value = entry.irritability
            case .menstrualCycle:
                value = entry.menstrualCycle
            }
            return (entry.date, value)
        }
    }
}

// Extension to format dates for display
extension Date {
    func formattedForChart() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }
} 
