import Foundation

extension Responses {
    public final class Toot: Codable {
        public let account: Account
        public let attachments: [Attachment]
        public let bookmarked: Bool?
        public let boosted: Bool?
        public let boostedToot: Toot?
        public let content: String
        public let contentWarning: String
        public let creationDate: Date
        public let emojis: [Emoji]
        public let favorited: Bool?
        public let id: String
        public let inReplyToAccountID: String?
        public let inReplyToID: String?
        public let isSensitive: Bool
        public let mentions: [Mention]
        public let tags: [Tag]
        public let url: URL?
    }
}

extension Responses.Toot {
    private enum CodingKeys: String, CodingKey {
        case account
        case attachments = "media_attachments"
        case bookmarked
        case boosted = "reblogged"
        case boostedToot = "reblog"
        case content
        case contentWarning = "spoiler_text"
        case creationDate = "created_at"
        case emojis
        case favorited = "favourited"
        case id
        case inReplyToAccountID = "in_reply_to_account_id"
        case inReplyToID = "in_reply_to_id"
        case isSensitive = "sensitive"
        case mentions
        case tags
        case url
    }
}
