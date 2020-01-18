import XCTest
@testable import MastodonKit

final class MastodonKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(MastodonKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
