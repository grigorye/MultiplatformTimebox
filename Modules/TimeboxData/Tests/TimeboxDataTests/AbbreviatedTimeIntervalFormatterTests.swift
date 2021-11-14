import XCTest
@testable import TimeboxData

class AbbreviatedTimeIntervalFormatterTests : XCTestCase {
    
    func test() {
        assertEquivalent(string: "1s", ti: 1)
        assertEquivalent(string: "1m", ti: 60)
        assertEquivalent(string: "1h", ti: 60 * 60)
        assertEquivalent(string: "1d", ti: 60 * 60 * 24)
    }

    private func assertEquivalent(string: String, ti: TimeInterval, file: StaticString = #file, line: UInt = #line) {
        let x = AbbreviatedTimeIntervalFormatter()
        XCTAssertEqual(string, x.stringFromTimeInterval(ti), file: file, line: line)
        XCTAssertEqual(ti, x.timeIntervalFromString(string), file: file, line: line)
    }
    
    static var allTests = [
        ("test", test),
    ]
}
