@testable import MastodonKit
import XCTest

final class TagTests: XCTestCase {
    func testDecodingForHistory() {
        let data = """
            {
              "day": "1574553600",
              "uses": "200",
              "accounts": "31"
            }
            """
            .data(using: .utf8)!

        let history = try! Client.makeJSONDecoder().decode(Tag.History.self, from: data)
        XCTAssertEqual(history.day, 1574553600)
        XCTAssertEqual(history.uses, 200)
        XCTAssertEqual(history.accounts, 31)
    }
}
