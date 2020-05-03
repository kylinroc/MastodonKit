@testable import MastodonKit
import XCTest

final class TootTest: XCTestCase {
    func testDecoding() throws {
        let data = #"""
            {
              "id": "103270115826048975",
              "created_at": "2019-12-08T03:48:33.901Z",
              "in_reply_to_id": null,
              "in_reply_to_account_id": null,
              "sensitive": false,
              "spoiler_text": "",
              "visibility": "public",
              "language": "en",
              "uri": "https://mastodon.social/users/Gargron/statuses/103270115826048975",
              "url": "https://mastodon.social/@Gargron/103270115826048975",
              "replies_count": 5,
              "reblogs_count": 6,
              "favourites_count": 11,
              "favourited": false,
              "reblogged": false,
              "muted": false,
              "bookmarked": false,
              "content": "<p>&quot;I lost my inheritance with one wrong digit on my sort code&quot;</p><p><a href=\"https://www.theguardian.com/money/2019/dec/07/i-lost-my-193000-inheritance-with-one-wrong-digit-on-my-sort-code\" rel=\"nofollow noopener noreferrer\" target=\"_blank\"><span class=\"invisible\">https://www.</span><span class=\"ellipsis\">theguardian.com/money/2019/dec</span><span class=\"invisible\">/07/i-lost-my-193000-inheritance-with-one-wrong-digit-on-my-sort-code</span}</p>",
              "reblog": null,
              "application": {
                "name": "Web",
                "website": null
              },
              "account": {
                "id": "1",
                "username": "Gargron",
                "acct": "Gargron",
                "display_name": "Eugen",
                "locked": false,
                "bot": false,
                "discoverable": true,
                "group": false,
                "created_at": "2016-03-16T14:34:26.392Z",
                "note": "<p>Developer of Mastodon and administrator of mastodon.social. I post service announcements, development updates, and personal stuff.</p>",
                "url": "https://mastodon.social/@Gargron",
                "avatar": "https://files.mastodon.social/accounts/avatars/000/000/001/original/d96d39a0abb45b92.jpg",
                "avatar_static": "https://files.mastodon.social/accounts/avatars/000/000/001/original/d96d39a0abb45b92.jpg",
                "header": "https://files.mastodon.social/accounts/headers/000/000/001/original/c91b871f294ea63e.png",
                "header_static": "https://files.mastodon.social/accounts/headers/000/000/001/original/c91b871f294ea63e.png",
                "followers_count": 322930,
                "following_count": 459,
                "statuses_count": 61323,
                "last_status_at": "2019-12-10T08:14:44.811Z",
                "emojis": [],
                "fields": [
                  {
                    "name": "Patreon",
                    "value": "<a href=\"https://www.patreon.com/mastodon\" rel=\"me nofollow noopener noreferrer\" target=\"_blank\"><span class=\"invisible\">https://www.</span><span class=\"\">patreon.com/mastodon</span><span class=\"invisible\"></span}",
                    "verified_at": null
                  },
                  {
                    "name": "Homepage",
                    "value": "<a href=\"https://zeonfederated.com\" rel=\"me nofollow noopener noreferrer\" target=\"_blank\"><span class=\"invisible\">https://</span><span class=\"\">zeonfederated.com</span><span class=\"invisible\"></span}",
                    "verified_at": "2019-07-15T18:29:57.191+00:00"
                  }
                ]
              },
              "media_attachments": [],
              "mentions": [],
              "tags": [],
              "emojis": [],
              "card": {
                "url": "https://www.theguardian.com/money/2019/dec/07/i-lost-my-193000-inheritance-with-one-wrong-digit-on-my-sort-code",
                "title": "‘I lost my £193,000 inheritance – with one wrong digit on my sort code’",
                "description": "When Peter Teich’s money went to another Barclays customer, the bank offered £25 as a token gesture",
                "type": "link",
                "author_name": "",
                "author_url": "",
                "provider_name": "",
                "provider_url": "",
                "html": "",
                "width": 0,
                "height": 0,
                "image": null,
                "embed_url": ""
              },
              "poll": null
            }
            """#
            .data(using: .utf8)!

        let toot = try! Client.makeJSONDecoder().decode(Toot.self, from: data)
        XCTAssertEqual(toot.id, "103270115826048975")
        XCTAssertEqual(toot.uri, "https://mastodon.social/users/Gargron/statuses/103270115826048975")
        XCTAssertEqual(toot.creationDate, Client.dateFormatter.date(from: "2019-12-08T03:48:33.901Z"))
        XCTAssertEqual(toot.content, "<p>&quot;I lost my inheritance with one wrong digit on my sort code&quot;</p><p><a href=\"https://www.theguardian.com/money/2019/dec/07/i-lost-my-193000-inheritance-with-one-wrong-digit-on-my-sort-code\" rel=\"nofollow noopener noreferrer\" target=\"_blank\"><span class=\"invisible\">https://www.</span><span class=\"ellipsis\">theguardian.com/money/2019/dec</span><span class=\"invisible\">/07/i-lost-my-193000-inheritance-with-one-wrong-digit-on-my-sort-code</span}</p>")
        XCTAssertEqual(toot.reblogsCount, 6)
        XCTAssertEqual(toot.favouritesCount, 11)
        XCTAssertEqual(toot.url, URL(string: "https://mastodon.social/@Gargron/103270115826048975"))
        XCTAssertNil(toot.inReplyToID)
        XCTAssertNil(toot.boostedToot)
        XCTAssertEqual(toot.favourited, false)
        XCTAssertEqual(toot.reblogged, false)
        XCTAssertEqual(toot.visibility, .public)
        XCTAssertFalse(toot.isSensitive)
        XCTAssertEqual(toot.spoilerText, "")
        XCTAssertNil(toot.inReplyToAccountID)
        XCTAssertEqual(toot.language, "en")
        XCTAssertEqual(toot.muted, false)
        XCTAssertNil(toot.pinned)
        XCTAssertEqual(toot.repliesCount, 5)
        XCTAssertNotNil(toot.card)
        XCTAssertNil(toot.poll)
        XCTAssertEqual(toot.bookmarked, false)
    }
}
