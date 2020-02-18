@testable import MastodonKit
import XCTest

final class CardTests: XCTestCase {
    func testDecoding() {
        let data = #"""
            {
              "url": "https://www.youtube.com/watch?v=OMv_EPMED8Y",
              "title": "♪ Brand New Friend (Christmas Song!)",
              "description": "",
              "type": "video",
              "author_name": "YOGSCAST Lewis & Simon",
              "author_url": "https://www.youtube.com/user/BlueXephos",
              "provider_name": "YouTube",
              "provider_url": "https://www.youtube.com/",
              "html": "<iframe width=\"480\" height=\"270\" src=\"https://www.youtube.com/embed/OMv_EPMED8Y?feature=oembed\" frameborder=\"0\" allowfullscreen=\"\"></iframe>",
              "width": 480,
              "height": 270,
              "image": "https://files.mastodon.social/preview_cards/images/014/179/145/original/9cf4b7cf5567b569.jpeg",
              "embed_url": ""
            }
            """#
            .data(using: .utf8)!

        let card = try! Client.makeJSONDecoder().decode(Card.self, from: data)
        XCTAssertEqual(card.url, URL(string: "https://www.youtube.com/watch?v=OMv_EPMED8Y"))
        XCTAssertEqual(card.title, "♪ Brand New Friend (Christmas Song!)")
        XCTAssertEqual(card.description, "")
        XCTAssertEqual(card.image, URL(string: "https://files.mastodon.social/preview_cards/images/014/179/145/original/9cf4b7cf5567b569.jpeg"))
        XCTAssertEqual(card.type, .video)
        XCTAssertEqual(card.authorName, "YOGSCAST Lewis & Simon")
        XCTAssertEqual(card.authorURL, URL(string: "https://www.youtube.com/user/BlueXephos"))
        XCTAssertEqual(card.providerName, "YouTube")
        XCTAssertEqual(card.providerURL, URL(string: "https://www.youtube.com/"))
        XCTAssertEqual(card.html, "<iframe width=\"480\" height=\"270\" src=\"https://www.youtube.com/embed/OMv_EPMED8Y?feature=oembed\" frameborder=\"0\" allowfullscreen=\"\"></iframe>")
        XCTAssertEqual(card.width, 480)
        XCTAssertEqual(card.height, 270)
        XCTAssertEqual(card.embedURL, nil)
    }
}
