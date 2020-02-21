@testable import MastodonKit
import XCTest

final class SourceTests: XCTestCase {
    func testDecoding() {
        let data = #"""
            {
              "privacy": "public",
              "sensitive": false,
              "language": "",
              "note": "i have approximate knowledge of many things. perpetual student. (nb/ace/they)\r\n\r\nxmpp/email: a@trwnh.com\r\nhttps://trwnh.com\r\nhelp me live: https://liberapay.com/at or https://paypal.me/trwnh\r\n\r\n- my triggers are moths and glitter\r\n- i have all notifs except mentions turned off, so please interact if you wanna be friends! i literally will not notice otherwise\r\n- dm me if i did something wrong, so i can improve\r\n- purest person on fedi, do not lewd in my presence\r\n- #1 ami cole fan account\r\n\r\n:fatyoshi:",
              "fields": [
                {
                  "name": "Website",
                  "value": "https://trwnh.com",
                  "verified_at": "2019-08-29T04:14:55.571+00:00"
                },
                {
                  "name": "Sponsor",
                  "value": "https://liberapay.com/at",
                  "verified_at": "2019-11-15T10:06:15.557+00:00"
                },
                {
                  "name": "Fan of:",
                  "value": "Punk-rock and post-hardcore (Circa Survive, letlive., La Dispute, THE FEVER 333)Manga (Yu-Gi-Oh!, One Piece, JoJo's Bizarre Adventure, Death Note, Shaman King)Platformers and RPGs (Banjo-Kazooie, Boktai, Final Fantasy Crystal Chronicles)",
                  "verified_at": null
                },
                {
                  "name": "Main topics:",
                  "value": "systemic analysis, design patterns, anticapitalism, info/tech freedom, theory and philosophy, and otherwise being a genuine and decent wholesome poster. i'm just here to hang out and talk to cool people!",
                  "verified_at": null
                }
              ],
              "follow_requests_count": 0
            }
            """#
            .data(using: .utf8)!

        let source = try! Client.makeJSONDecoder().decode(Source.self, from: data)
        XCTAssertEqual(source.note, "i have approximate knowledge of many things. perpetual student. (nb/ace/they)\r\n\r\nxmpp/email: a@trwnh.com\r\nhttps://trwnh.com\r\nhelp me live: https://liberapay.com/at or https://paypal.me/trwnh\r\n\r\n- my triggers are moths and glitter\r\n- i have all notifs except mentions turned off, so please interact if you wanna be friends! i literally will not notice otherwise\r\n- dm me if i did something wrong, so i can improve\r\n- purest person on fedi, do not lewd in my presence\r\n- #1 ami cole fan account\r\n\r\n:fatyoshi:")
        XCTAssertEqual(source.privacy, .public)
        XCTAssertEqual(source.sensitive, false)
        XCTAssertEqual(source.language, "")
        XCTAssertEqual(source.followRequestsCount, 0)
    }
}
