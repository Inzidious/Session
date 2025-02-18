import SwiftUI

class PromptCluster: ObservableObject {
    var promptEntries = [PromptEntry]()
    @Published var selectedEntry: PromptEntry
    
    init() {
        promptEntries.append(PromptEntry(id:0, question:"First prompt question"))
        promptEntries.append(PromptEntry(id:1, question:"Second prompt question"))
        promptEntries.append(PromptEntry(id:2, question:"Third prompt question"))
        promptEntries.append(PromptEntry(id:3, question:"Fourth prompt question"))
        promptEntries.append(PromptEntry(id:4, question:"Fifth prompt question"))
        
        selectedEntry = promptEntries[0]
    }
}

struct PromptEntry: Identifiable {
    let id: UUID = UUID()
    var isFilled: Bool = false
    var promptAnswer: String = "EMPTY_ANSWER"
    var promptQuestion: String
    var promptID: Int
    var journalEntry: JournalEntry?
    
    init(id: Int, question: String) {
        promptID = id
        promptQuestion = question
    }
}

@Query var users: [User]  // Array of User objects 