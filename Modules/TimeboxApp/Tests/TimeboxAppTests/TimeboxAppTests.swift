import XCTest
@testable import TimeboxApp

final class TimeboxAppTests: XCTestCase {
    func testExample() {
        XCTAssertEqual(TimeboxApp().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
