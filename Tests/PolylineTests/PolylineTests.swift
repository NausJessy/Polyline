import XCTest
@testable import Polyline

final class PolylineTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Polyline().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
