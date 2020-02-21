@testable import MastodonKit
import XCTest

final class TagTests: XCTestCase {
    func testDecoding() {
        let data = """
            {
              "name": "nowplaying",
              "url": "https://mastodon.social/tags/nowplaying",
              "history": [
                {
                  "day": "1574553600",
                  "uses": "200",
                  "accounts": "31"
                },
                {
                  "day": "1574467200",
                  "uses": "272",
                  "accounts": "39"
                },
                {
                  "day": "1574380800",
                  "uses": "345",
                  "accounts": "40"
                },
                {
                  "day": "1574294400",
                  "uses": "366",
                  "accounts": "46"
                },
                {
                  "day": "1574208000",
                  "uses": "226",
                  "accounts": "32"
                },
                {
                  "day": "1574121600",
                  "uses": "217",
                  "accounts": "42"
                },
                {
                  "day": "1574035200",
                  "uses": "214",
                  "accounts": "34"
                }
              ]
            }
            """
            .data(using: .utf8)!

        let tag = try! Client.makeJSONDecoder().decode(Tag.self, from: data)
        XCTAssertEqual(tag.name, "nowplaying")
        XCTAssertEqual(tag.url, URL(string: "https://mastodon.social/tags/nowplaying"))
        XCTAssertEqual(tag.history.count, 7)
    }

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
