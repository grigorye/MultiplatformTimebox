import XCTest
@testable import TimeboxApp

final class TimeboxAppTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TimeboxApp().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
