import XCTest

final class AuthenticationUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    func testGuestUserFlow() {
        // Test the "Continue as Guest" flow
        let guestButton = app.buttons["Continue As Guest"]
        XCTAssertTrue(guestButton.exists)
        
        guestButton.tap()
        
        // Verify we're on the main app screen
        let homeTab = app.tabBars.buttons["Home"]
        XCTAssertTrue(homeTab.exists)
        
        // Verify guest user info is displayed
        let welcomeText = app.staticTexts["Welcome back, Guest!"]
        XCTAssertTrue(welcomeText.exists)
    }
    
    func testProfileNavigation() {
        // First continue as guest
        app.buttons["Continue As Guest"].tap()
        
        // Navigate to profile
        app.buttons["person.circle.fill"].tap()
        
        // Verify profile elements
        let personalInfoButton = app.buttons["Personal Information"]
        XCTAssertTrue(personalInfoButton.exists)
        
        // Test expanding personal info section
        personalInfoButton.tap()
        
        // Verify fields are present
        let emailField = app.textFields["Email"]
        XCTAssertTrue(emailField.exists)
    }
} 