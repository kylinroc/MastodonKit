@testable import MastodonKit
import XCTest

final class AccountTests: XCTestCase {
    func testDecoding() {
        let data = #"""
            {
              "id": "23634",
              "username": "noiob",
              "acct": "noiob@awoo.space",
              "display_name": "ikea shark fan account",
              "locked": false,
              "bot": false,
              "created_at": "2017-02-08T02:00:53.274Z",
              "note": "<p>:ms_rainbow_flag:​ :ms_bisexual_flagweb:​ :ms_nonbinary_flag:​ <a href=\"https://awoo.space/tags/awoo\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>awoo</span}.space <a href=\"https://awoo.space/tags/admin\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>admin</span} ~ <a href=\"https://awoo.space/tags/bi\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>bi</span} ~ <a href=\"https://awoo.space/tags/nonbinary\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>nonbinary</span} ~ compsci student ~ likes video <a href=\"https://awoo.space/tags/games\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>games</span} and weird/ old electronics and will post obsessively about both ~ avatar by <span class=\"h-card\"><a href=\"https://weirder.earth/@dzuk\" class=\"u-url mention\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">@<span>dzuk</span}</span></p>",
              "url": "https://awoo.space/@noiob",
              "avatar": "https://files.mastodon.social/accounts/avatars/000/023/634/original/6ca8804dc46800ad.png",
              "avatar_static": "https://files.mastodon.social/accounts/avatars/000/023/634/original/6ca8804dc46800ad.png",
              "header": "https://files.mastodon.social/accounts/headers/000/023/634/original/256eb8d7ac40f49a.png",
              "header_static": "https://files.mastodon.social/accounts/headers/000/023/634/original/256eb8d7ac40f49a.png",
              "followers_count": 547,
              "following_count": 404,
              "statuses_count": 28468,
              "last_status_at": "2019-11-17T00:02:23.693Z",
              "emojis": [
                {
                  "shortcode": "ms_rainbow_flag",
                  "url": "https://files.mastodon.social/custom_emojis/images/000/028/691/original/6de008d6281f4f59.png",
                  "static_url": "https://files.mastodon.social/custom_emojis/images/000/028/691/static/6de008d6281f4f59.png",
                  "visible_in_picker": true
                },
                {
                  "shortcode": "ms_bisexual_flag",
                  "url": "https://files.mastodon.social/custom_emojis/images/000/050/744/original/02f94a5fca7eaf78.png",
                  "static_url": "https://files.mastodon.social/custom_emojis/images/000/050/744/static/02f94a5fca7eaf78.png",
                  "visible_in_picker": true
                },
                {
                  "shortcode": "ms_nonbinary_flag",
                  "url": "https://files.mastodon.social/custom_emojis/images/000/105/099/original/8106088bd4782072.png",
                  "static_url": "https://files.mastodon.social/custom_emojis/images/000/105/099/static/8106088bd4782072.png",
                  "visible_in_picker": true
                }
              ],
              "fields": [
                {
                  "name": "Pronouns",
                  "value": "they/them",
                  "verified_at": null
                },
                {
                  "name": "Alt",
                  "value": "<span class=\"h-card\"><a href=\"https://cybre.space/@noiob\" class=\"u-url mention\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">@<span>noiob</span}</span>",
                  "verified_at": null
                },
                {
                  "name": "Bots",
                  "value": "<span class=\"h-card\"><a href=\"https://botsin.space/@darksouls\" class=\"u-url mention\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">@<span>darksouls</span}</span>, <span class=\"h-card\"><a href=\"https://botsin.space/@nierautomata\" class=\"u-url mention\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">@<span>nierautomata</span}</span>, <span class=\"h-card\"><a href=\"https://mastodon.social/@fedi\" class=\"u-url mention\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">@<span>fedi</span}</span>, code for <span class=\"h-card\"><a href=\"https://botsin.space/@awoobot\" class=\"u-url mention\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">@<span>awoobot</span}</span>",
                  "verified_at": null
                },
                {
                  "name": "Website",
                  "value": "<a href=\"http://shork.xyz\" rel=\"nofollow noopener noreferrer\" target=\"_blank\"><span class=\"invisible\">http://</span><span class=\"\">shork.xyz</span><span class=\"invisible\"></span}",
                  "verified_at": "2019-11-10T10:31:10.744+00:00"
                }
              ]
            }
            """#
            .data(using: .utf8)!

        let account = try! Client.makeJSONDecoder().decode(Account.self, from: data)
        XCTAssertEqual(account.id, "23634")
        XCTAssertEqual(account.username, "noiob")
        XCTAssertEqual(account.acct, "noiob@awoo.space")
        XCTAssertEqual(account.url, URL(string: "https://awoo.space/@noiob"))
        XCTAssertEqual(account.displayName, "ikea shark fan account")
        XCTAssertEqual(account.note, "<p>:ms_rainbow_flag:​ :ms_bisexual_flagweb:​ :ms_nonbinary_flag:​ <a href=\"https://awoo.space/tags/awoo\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>awoo</span}.space <a href=\"https://awoo.space/tags/admin\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>admin</span} ~ <a href=\"https://awoo.space/tags/bi\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>bi</span} ~ <a href=\"https://awoo.space/tags/nonbinary\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>nonbinary</span} ~ compsci student ~ likes video <a href=\"https://awoo.space/tags/games\" class=\"mention hashtag\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">#<span>games</span} and weird/ old electronics and will post obsessively about both ~ avatar by <span class=\"h-card\"><a href=\"https://weirder.earth/@dzuk\" class=\"u-url mention\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">@<span>dzuk</span}</span></p>")
        XCTAssertEqual(account.avatarURL, URL(string: "https://files.mastodon.social/accounts/avatars/000/023/634/original/6ca8804dc46800ad.png"))
        XCTAssertEqual(account.header, URL(string: "https://files.mastodon.social/accounts/headers/000/023/634/original/256eb8d7ac40f49a.png"))
        XCTAssertFalse(account.locked)
        XCTAssertEqual(account.createdAt, Client.dateFormatter.date(from: "2017-02-08T02:00:53.274Z"))
        XCTAssertEqual(account.tootsCount, 28468)
        XCTAssertEqual(account.followersCount, 547)
        XCTAssertEqual(account.followingCount, 404)
        XCTAssertEqual(account.staticAvatarURL, URL(string: "https://files.mastodon.social/accounts/avatars/000/023/634/original/6ca8804dc46800ad.png"))
        XCTAssertEqual(account.headerStatic, URL(string: "https://files.mastodon.social/accounts/headers/000/023/634/original/256eb8d7ac40f49a.png"))
        XCTAssertNil(account.moved)
        XCTAssertFalse(account.bot)
        XCTAssertFalse(account.discoverable)
    }
}
