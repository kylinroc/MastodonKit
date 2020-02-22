@testable import MastodonKit
import XCTest

final class PollTests: XCTestCase {
    func testDecoding() throws {
        let data = """
            {
              "id": "34830",
              "expires_at": "2019-12-05T04:05:08.302Z",
              "expired": true,
              "multiple": false,
              "votes_count": 10,
              "voters_count": null,
              "voted": true,
              "own_votes": [
                1
              ],
              "options": [
                {
                  "title": "accept",
                  "votes_count": 6
                },
                {
                  "title": "deny",
                  "votes_count": 4
                }
              ],
              "emojis": []
            }
            """
            .data(using: .utf8)!

        let poll = try Client.makeJSONDecoder().decode(Poll.self, from: data)
        XCTAssertEqual(poll.id, "34830")
        XCTAssertEqual(poll.expiresAt, Client.dateFormatter.date(from: "2019-12-05T04:05:08.302Z"))
        XCTAssertTrue(poll.expired)
        XCTAssertFalse(poll.multiple)
        XCTAssertEqual(poll.votesCount, 10)
        XCTAssertNil(poll.votersCount)
        XCTAssertEqual(poll.ownVotes, [1])
    }

    func testDecodingForOption() throws {
        let data = """
            {
              "title": "accept",
              "votes_count": 6
            }
            """
            .data(using: .utf8)!

        let option = try Client.makeJSONDecoder().decode(Poll.Option.self, from: data)
        XCTAssertEqual(option.title, "accept")
        XCTAssertEqual(option.votesCount, 6)
    }
}
