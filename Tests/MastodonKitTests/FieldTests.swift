@testable import MastodonKit
import XCTest

final class FieldTests: XCTestCase {
    func testDecoding() {
        let data = """
            {
              "name": "Website",
              "value": "https://trwnh.com",
              "verified_at": "2019-08-29T04:14:55.571+00:00"
            }
            """
            .data(using: .utf8)!

        let field = try! Client.makeJSONDecoder().decode(Field.self, from: data)
        XCTAssertEqual(field.name, "Website")
        XCTAssertEqual(field.value, "https://trwnh.com")
        XCTAssertEqual(field.verifiedAt, Client.dateFormatter.date(from: "2019-08-29T04:14:55.571+00:00"))
    }
}
