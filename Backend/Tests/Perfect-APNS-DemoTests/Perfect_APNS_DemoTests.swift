import XCTest
@testable import Perfect_APNS_Demo

class Perfect_APNS_DemoTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Perfect_APNS_Demo().text, "Hello, World!")
    }


    static var allTests : [(String, (Perfect_APNS_DemoTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
