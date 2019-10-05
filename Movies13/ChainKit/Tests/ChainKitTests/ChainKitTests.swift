import XCTest
@testable import ChainKit

final class ChainKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ChainKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
