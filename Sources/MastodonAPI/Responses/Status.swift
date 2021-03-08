import Foundation

extension Responses {
    public final class Status: Decodable {
        // 0.1.0
        public let id: String

        // 0.1.0
        public let account: Account

        // 0.1.0
        public let contentWarning: String

        // 0.1.0
        public let content: String

        // 0.1.0
        public let creationDate: Date

        // 0.1.0
        public let isReblogged: Bool

        // 0.1.0
        public let isFavorited: Bool

        // 0.1.0
        public let reblogsCount: Int

        // 0.1.0
        public let favoritesCount: Int

        // 0.1.0
        public let rebloggedStatus: Status?

        // 0.6.0
        public let attachments: [Attachment]

        // 0.9.9
        public let isSensitive: Bool

        // 0.9.9
        public let visibility: Visibility

        // 2.0.0
        public let emojis: [Emoji]

        // 2.5.0
        public let repliesCount: Int

        // 2.8.0
        public let poll: Poll?

        // 3.1.0
        public let isBookmarked: Bool

        private enum CodingKeys: String, CodingKey {
            case id
            case account
            case contentWarning = "spoiler_text"
            case content
            case creationDate = "created_at"
            case isReblogged = "reblogged"
            case isFavorited = "favourited"
            case reblogsCount = "reblogs_count"
            case favoritesCount = "favourites_count"
            case rebloggedStatus = "reblog"
            case attachments = "media_attachments"
            case isSensitive = "sensitive"
            case visibility
            case emojis
            case repliesCount = "replies_count"
            case poll
            case isBookmarked = "bookmarked"
        }
    }
}
