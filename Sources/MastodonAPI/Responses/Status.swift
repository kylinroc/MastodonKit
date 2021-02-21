import Foundation

extension Responses {
    public final class Status: Decodable {
        public let id: String
        public let account: Account
        public let contentWarning: String
        public let content: String
        public let emojis: [Emoji]
        public let attachments: [Attachment]
        public let isSensitive: Bool
        public let poll: Poll?
        public let creationDate: Date
        public let visibility: Visibility
        public let isReblogged: Bool
        public let isFavorited: Bool
        public let isBookmarked: Bool
        public let repliesCount: Int
        public let boostsCount: Int
        public let favoritesCount: Int
        public let rebloggedStatus: Status?

        private enum CodingKeys: String, CodingKey {
            case id
            case account
            case contentWarning = "spoiler_text"
            case content
            case emojis
            case attachments = "media_attachments"
            case isSensitive = "sensitive"
            case poll
            case creationDate = "created_at"
            case visibility
            case isReblogged = "reblogged"
            case isFavorited = "favourited"
            case isBookmarked = "bookmarked"
            case repliesCount = "replies_count"
            case boostsCount = "reblogs_count"
            case favoritesCount = "favourites_count"
            case rebloggedStatus = "reblog"
        }
    }
}
