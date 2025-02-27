import XCTest
import SwiftData
@testable import SessionApp

final class UserTests: XCTestCase {
    var context: ModelContext!
    
    override func setUp() {
        super.setUp()
        // Create an in-memory container for testing
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(
            for: User.self,
            configurations: config
        )
        context = ModelContainer.shared.mainContext
    }
    
    func testCreateUser() {
        // Given
        let user = User(
            id: "test_id",
            email: "test@example.com",
            firstName: "Test",
            lastName: "User",
            authProvider: "test"
        )
        
        // When
        context.insert(user)
        
        // Then
        XCTAssertNotNil(user.id)
        XCTAssertEqual(user.email, "test@example.com")
        XCTAssertEqual(user.firstName, "Test")
    }
    
    func testDemoDataLoading() {
        // Given
        DemoDataLoader.loadDemoUser(context: context)
        
        // When
        let fetchDescriptor = FetchDescriptor<User>()
        let users = try? context.fetch(fetchDescriptor)
        
        // Then
        XCTAssertNotNil(users)
        XCTAssertEqual(users?.count, 1)
        XCTAssertEqual(users?.first?.firstName, "Demo")
        XCTAssertNotNil(users?.first?.journalEntries)
    }
} 