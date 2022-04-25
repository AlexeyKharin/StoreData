


import XCTest
@testable import Navigation

class NavigationUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.activate()
        
        app.tabBars["Tab Bar"].buttons["Profile"].tap()
        
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText("Egor")
        app.buttons["continue"].tap()
        
        app.secureTextFields["Password"].typeText("123456")
        app.buttons["done"].tap()

        app/*@START_MENU_TOKEN@*/.staticTexts["Log in"]/*[[".buttons[\"Log in\"].staticTexts[\"Log in\"]",".staticTexts[\"Log in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let navigationTitle = app.navigationBars["ProfileView"]
        
        XCTAssert(navigationTitle.waitForExistence(timeout: 1.0))
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
