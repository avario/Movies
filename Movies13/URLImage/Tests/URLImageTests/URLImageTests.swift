import XCTest
@testable import URLImage

final class URLImageTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(URLImage().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
