import Foundation

extension Responses {
    public final class Toot: Decodable {
        public let id: String
        public let account: Account
        public let content: String
        public let attachments: [Attachment]
        public let creationDate: Date
        public let visibility: Visibility
        public let repliesCount: Int
        public let boostsCount: Int
        public let favoritesCount: Int
        public let boostedToot: Toot?

        private enum CodingKeys: String, CodingKey {
            case id
            case account
            case content
            case attachments = "media_attachments"
            case creationDate = "created_at"
            case visibility
            case repliesCount = "replies_count"
            case boostsCount = "reblogs_count"
            case favoritesCount = "favourites_count"
            case boostedToot = "reblog"
        }
    }
}
