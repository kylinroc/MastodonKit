import Foundation

extension Responses {
    /// Represents a toot posted by an account.
    public final class Toot: Codable {
        public enum Visibility: String, Codable {
            case `public`
            case unlisted
            case `private`
            case direct
        }

        /// ID of the toot in the database.
        ///
        /// Added in 0.1.0
        public let id: String

        /// URI of the toot used for federation.
        ///
        /// Added in 0.1.0
        public let uri: String

        /// The date when this toot was created.
        ///
        /// Added in 0.1.0
        public let creationDate: Date

        /// The account that authored this toot.
        ///
        /// Added in 0.1.0
        public let account: Account

        /// HTML-encoded toot content.
        ///
        /// Added in 0.1.0
        public let content: String

        /// How many boosts this toot has received.
        ///
        /// Added in 0.1.0
        public let boostCount: Int

        /// How many favorites this toot has received.
        ///
        /// Added in 0.1.0
        public let favoriteCount: Int

        /// A link to the toot's HTML representation.
        ///
        /// Added in 0.1.0
        public let url: URL?

        /// ID of the toot being replied.
        ///
        /// Added in 0.1.0
        public let inReplyToID: String?

        /// The toot being reblogged.
        ///
        /// Added in 0.1.0
        public let boostedToot: Toot?

        /// Have you favourited this toot?
        ///
        /// Added in 0.1.0
        public let favorited: Bool?

        /// Have you boosted this toot?
        ///
        /// Added in 0.1.0
        public let boosted: Bool?

        /// Media that is attached to this toot.
        ///
        /// Added in 0.6.0
        public let attachments: [Attachment]

        /// Mentions of users within the toot content.
        ///
        /// Added in 0.6.0
        public let mentions: [Mention]

        /// Hashtags used within the toot content.
        ///
        /// Added in 0.9.0
        public let tags: [Tag]

        /// Visibility of this toot.
        ///
        /// Added in 0.9.9
        public let visibility: Visibility

        /// Is this toot marked as sensitive content?
        ///
        /// Added in 0.9.9
        public let isSensitive: Bool

        /// The application used to post this toot.
        ///
        /// Added in 0.9.9
        public let application: Application?

        /// Subject or summary line, below which toot content is collapsed until expanded.
        ///
        /// Added in 1.0.0
        public let contentWarning: String

        /// ID of the account being replied to.
        ///
        /// Added in 1.0.0
        public let inReplyToAccountID: String?

        /// Primary language of this toot.
        ///
        /// Added in 1.4.0
        public let language: String?

        /// Have you muted notifications for this toot's conversation?
        ///
        /// Added in 1.4.0
        public let muted: Bool?

        /// Have you pinned this toot? Only appears if the toot is pinnable.
        ///
        /// Added in 1.6.0
        public let pinned: Bool?

        /// Custom emoji to be used when rendering toot content.
        ///
        /// Added in 2.0.0
        public let emojis: [Emoji]

        /// How many replies this toot has received.
        ///
        /// Added in 2.5.0
        public let repliesCount: Int?

        /// The poll attached to the toot.
        ///
        /// Added in 2.8.0
        public let poll: Poll?

        /// Have you bookmarked this toot?
        ///
        /// Added in 3.1.0
        public let bookmarked: Bool?

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            uri = try container.decode(String.self, forKey: .uri)
            creationDate = try container.decode(Date.self, forKey: .creationDate)
            account = try container.decode(Account.self, forKey: .account)
            content = try container.decode(String.self, forKey: .content)
            boostCount = try container.decode(Int.self, forKey: .boostCount)
            favoriteCount = try container.decode(Int.self, forKey: .favoriteCount)

            if let string = try container.decodeIfPresent(String.self, forKey: .url) {
                if let url = URL(string: string) {
                    self.url = url
                } else if let string = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                          let url = URL(string: string) {
                    self.url = url
                } else {
                    self.url = nil
                }
            } else {
                self.url = nil
            }

            inReplyToID = try container.decodeIfPresent(String.self, forKey: .inReplyToID)
            boostedToot = try container.decodeIfPresent(Toot.self, forKey: .boostedToot)
            favorited = try container.decodeIfPresent(Bool.self, forKey: .favorited)
            boosted = try container.decodeIfPresent(Bool.self, forKey: .boosted)
            attachments = try container.decode([Attachment].self, forKey: .attachments)
            mentions = try container.decode([Mention].self, forKey: .mentions)
            tags = try container.decode([Tag].self, forKey: .tags)
            visibility = try container.decode(Visibility.self, forKey: .visibility)
            isSensitive = try container.decode(Bool.self, forKey: .isSensitive)
            application = try container.decodeIfPresent(Application.self, forKey: .application)
            contentWarning = try container.decode(String.self, forKey: .contentWarning)
            inReplyToAccountID = try container.decodeIfPresent(String.self, forKey: .inReplyToAccountID)
            language = try container.decodeIfPresent(String.self, forKey: .language)
            muted = try container.decodeIfPresent(Bool.self, forKey: .muted)
            pinned = try container.decodeIfPresent(Bool.self, forKey: .pinned)
            emojis = try container.decode([Emoji].self, forKey: .emojis)
            repliesCount = try container.decodeIfPresent(Int.self, forKey: .repliesCount)
            poll = try container.decodeIfPresent(Poll.self, forKey: .poll)
            bookmarked = try container.decodeIfPresent(Bool.self, forKey: .bookmarked)
        }
    }
}

extension Responses.Toot {
    private enum CodingKeys: String, CodingKey {
        case id
        case uri
        case creationDate = "created_at"
        case account
        case content
        case boostCount = "reblogs_count"
        case favoriteCount = "favourites_count"
        case url
        case inReplyToID = "in_reply_to_id"
        case boostedToot = "reblog"
        case favorited = "favourited"
        case boosted = "reblogged"
        case attachments = "media_attachments"
        case mentions
        case tags
        case visibility
        case isSensitive = "sensitive"
        case application
        case contentWarning = "spoiler_text"
        case inReplyToAccountID = "in_reply_to_account_id"
        case language
        case muted
        case pinned
        case emojis
        case repliesCount = "replies_count"
        case poll
        case bookmarked
    }
}

extension Responses.Toot {
    public func boost() -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(id)/reblog", httpMethod: .post, parameters: nil)
    }

    public func unboost() -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(id)/unreblog", httpMethod: .post, parameters: nil)
    }

    public func favorite() -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(id)/favourite", httpMethod: .post, parameters: nil)
    }

    public func unfavorite() -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(id)/unfavourite", httpMethod: .post, parameters: nil)
    }

    public func context() -> Request<Responses.Context> {
        Request(path: "/api/v1/statuses/\(id)/context", httpMethod: .get, parameters: nil)
    }

    public func bookmark() -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(id)/bookmark", httpMethod: .post, parameters: nil)
    }

    public func unbookmark() -> Request<Responses.Toot> {
        Request(path: "/api/v1/statuses/\(id)/unbookmark", httpMethod: .post, parameters: nil)
    }
}
