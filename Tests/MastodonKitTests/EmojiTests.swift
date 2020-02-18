import MastodonKit
import XCTest

final class EmojiTests: XCTestCase {
    func testDecoding() {
        let data = """
            {
              "shortcode": "blobaww",
              "url": "https://files.mastodon.social/custom_emojis/images/000/011/739/original/blobaww.png",
              "static_url": "https://files.mastodon.social/custom_emojis/images/000/011/739/static/blobaww.png",
              "visible_in_picker": true,
              "category": "Blobs"
            }
            """
            .data(using: .utf8)!

        let emoji = try! JSONDecoder().decode(Emoji.self, from: data)
        XCTAssertEqual(emoji.shortcode, "blobaww")
        XCTAssertEqual(emoji.url, URL(string: "https://files.mastodon.social/custom_emojis/images/000/011/739/original/blobaww.png"))
        XCTAssertEqual(emoji.staticURL, URL(string: "https://files.mastodon.social/custom_emojis/images/000/011/739/static/blobaww.png"))
        XCTAssertEqual(emoji.visibleInPicker, true)
        XCTAssertEqual(emoji.category, "Blobs")
    }
}

