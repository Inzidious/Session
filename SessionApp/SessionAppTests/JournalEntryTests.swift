import XCTest
@testable import SessionApp

final class JournalEntryTests: XCTestCase {
    var context: ModelContext!
    var user: User!
    
    override func setUp() {
        super.setUp()
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(
            for: User.self,
            JournalEntry.self,
            configurations: config
        )
        context = container.mainContext
        
        // Create a test user
        user = User(
            id: "test_id",
            email: "test@example.com",
            firstName: "Test",
            lastName: "User",
            authProvider: "test"
        )
        context.insert(user)
    }
    
    func testCreateJournalEntry() {
        // Given
        let entry = JournalEntry(
            promptId: 1,
            promptAnswer: "Test answer",
            sessionID: "test_session",
            sessionEntry: nil
        )
        
        // When
        user.journalEntries?.append(entry)
        
        // Then
        XCTAssertEqual(user.journalEntries?.count, 1)
        XCTAssertEqual(user.journalEntries?.first?.promptAnswer, "Test answer")
    }
} 