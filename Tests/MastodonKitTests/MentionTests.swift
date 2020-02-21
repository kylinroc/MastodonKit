@testable import MastodonKit
import XCTest

final class MentionTests: XCTestCase {
    func testDecoding() {
        let data = """
            {
              "id": "952529",
              "username": "alayna",
              "url": "https://desvox.es/users/alayna",
              "acct": "alayna@desvox.es"
            }
            """
            .data(using: .utf8)!

        let mention = try! Client.makeJSONDecoder().decode(Mention.self, from: data)
        XCTAssertEqual(mention.id, "952529")
        XCTAssertEqual(mention.username, "alayna")
        XCTAssertEqual(mention.acct, "alayna@desvox.es")
        XCTAssertEqual(mention.url, URL(string: "https://desvox.es/users/alayna"))
    }
}
