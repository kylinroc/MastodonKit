import Foundation

extension Responses {
    public final class Toot: Codable {
        public let id: String
        public let creationDate: Date
        public let account: Account
        public let content: String
        public let boostCount: Int
        public let favoriteCount: Int
        public let url: URL?
        public let inReplyToID: String?
        public let boostedToot: Toot?
        public let favorited: Bool?
        public let boosted: Bool?
        public let attachments: [Attachment]
        public let mentions: [Mention]
        public let tags: [Tag]
        public let isSensitive: Bool
        public let application: Application?
        public let contentWarning: String
        public let inReplyToAccountID: String?
        public let muted: Bool?
        public let pinned: Bool?
        public let emojis: [Emoji]
        public let repliesCount: Int?
        public let bookmarked: Bool?

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
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
            isSensitive = try container.decode(Bool.self, forKey: .isSensitive)
            application = try container.decodeIfPresent(Application.self, forKey: .application)
            contentWarning = try container.decode(String.self, forKey: .contentWarning)
            inReplyToAccountID = try container.decodeIfPresent(String.self, forKey: .inReplyToAccountID)
            muted = try container.decodeIfPresent(Bool.self, forKey: .muted)
            pinned = try container.decodeIfPresent(Bool.self, forKey: .pinned)
            emojis = try container.decode([Emoji].self, forKey: .emojis)
            repliesCount = try container.decodeIfPresent(Int.self, forKey: .repliesCount)
            bookmarked = try container.decodeIfPresent(Bool.self, forKey: .bookmarked)
        }
    }
}

extension Responses.Toot {
    private enum CodingKeys: String, CodingKey {
        case id
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
        case isSensitive = "sensitive"
        case application
        case contentWarning = "spoiler_text"
        case inReplyToAccountID = "in_reply_to_account_id"
        case muted
        case pinned
        case emojis
        case repliesCount = "replies_count"
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
}
