//  NavigationTests.swift

import XCTest
@testable import Navigation

class NavigationTests: XCTestCase {
    
    var mock: LoginMockImpl!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mock = LoginMockImpl()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mock = nil
    }
    
    func testSuccessAuthorization() throws {
        //Given
        let email: UITextField = UITextField()
        let pswd: UITextField = UITextField()
        email.text = "Egor"
        pswd.text = "123456"
        var expectredResult = 0
        
        //When
        mock.typeEmailAndPswd(email: email.text!, pswd: pswd.text!)
        expectredResult = mock.successAuthorizationCounter
        
        //Then
        XCTAssertEqual(expectredResult, 1)
        
        
    }
    
    func testSuccsessedCurrentUser() throws {
        //Given
        let email: UITextField = UITextField()
        let pswd: UITextField = UITextField()
        email.text = "Egor"
        pswd.text = "123456"
        let expectedResult = true
        var validateResult: Bool?
        let validatorExpectation = expectation(description: "Expectation in" + #function)
        
        //When
        mock.typeEmailAndPswd(email: email.text!, pswd: pswd.text!)
        mock.userLogIn = { currentUser in
            
            validateResult = currentUser
            
            validatorExpectation.fulfill()
        }
        
        //Then
        waitForExpectations(timeout: 1.5) { (error) in
            if error != nil {
                XCTFail()
            }
        }
        
        XCTAssertEqual(validateResult, expectedResult)
    }
    
    func testSuccsessefShowController() throws {
        
        //Given
        let email: UITextField = UITextField()
        let pswd: UITextField = UITextField()
        email.text = "Egor"
        pswd.text = "123456"
        var expectedResult = 0
        
        //When
        mock.typeEmailAndPswd(email: email.text!, pswd: pswd.text!)
        expectedResult = mock.displaySuccessControllerCounter
        
        //Then
        XCTAssertEqual(expectedResult, 1)
        
    }
    
}
