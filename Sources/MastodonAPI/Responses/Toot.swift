import Foundation

extension Responses {
    public final class Toot: Decodable {
        public let id: String
        public let account: Account
        public let contentWarning: String
        public let content: String
        public let attachments: [Attachment]
        public let isSensitive: Bool
        public let creationDate: Date
        public let visibility: Visibility
        public let isBoosted: Bool
        public let isFavorited: Bool
        public let isBookmarked: Bool
        public let repliesCount: Int
        public let boostsCount: Int
        public let favoritesCount: Int
        public let boostedToot: Toot?

        private enum CodingKeys: String, CodingKey {
            case id
            case account
            case contentWarning = "spoiler_text"
            case content
            case attachments = "media_attachments"
            case isSensitive = "sensitive"
            case creationDate = "created_at"
            case visibility
            case isBoosted = "reblogged"
            case isFavorited = "favourited"
            case isBookmarked = "bookmarked"
            case repliesCount = "replies_count"
            case boostsCount = "reblogs_count"
            case favoritesCount = "favourites_count"
            case boostedToot = "reblog"
        }
    }
}
