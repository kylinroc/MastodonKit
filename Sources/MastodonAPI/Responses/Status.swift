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

        // 0.1.0
        public let inReplyToID: String?

        // 0.1.0
        public let url: URL?

        // 0.6.0
        public let attachments: [Attachment]

        // 0.6.0
        public let mentions: [Mention]

        // 0.9.0
        public let tags: [Tag]

        // 0.9.9
        public let isSensitive: Bool

        // 0.9.9
        public let visibility: Visibility

        // 1.6.0
        public let pinned: Bool?

        // 2.0.0
        public let emojis: [Emoji]

        // 2.5.0
        public let repliesCount: Int

        // 2.8.0
        public let poll: Poll?

        // 3.1.0
        public let isBookmarked: Bool

        // MARK: Decodable

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
            case inReplyToID = "in_reply_to_id"
            case url
            case attachments = "media_attachments"
            case mentions
            case tags
            case isSensitive = "sensitive"
            case visibility
            case pinned
            case emojis
            case repliesCount = "replies_count"
            case poll
            case isBookmarked = "bookmarked"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            account = try container.decode(Account.self, forKey: .account)
            contentWarning = try container.decode(String.self, forKey: .contentWarning)
            content = try container.decode(String.self, forKey: .content)
            creationDate = try container.decode(Date.self, forKey: .creationDate)
            isReblogged = try container.decode(Bool.self, forKey: .isReblogged)
            isFavorited = try container.decode(Bool.self, forKey: .isFavorited)
            reblogsCount = try container.decode(Int.self, forKey: .reblogsCount)
            favoritesCount = try container.decode(Int.self, forKey: .favoritesCount)
            rebloggedStatus = try container.decodeIfPresent(Status.self, forKey: .rebloggedStatus)
            inReplyToID = try container.decodeIfPresent(String.self, forKey: .inReplyToID)

            if let string = try container.decodeIfPresent(String.self, forKey: .url) {
                if let url = URL(string: string) {
                    self.url = url
                } else if let string = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    url = URL(string: string)
                } else {
                    url = nil
                }
            } else {
                url = nil
            }

            attachments = try container.decode([Attachment].self, forKey: .attachments)
            mentions = try container.decode([Mention].self, forKey: .mentions)
            tags = try container.decode([Tag].self, forKey: .tags)
            isSensitive = try container.decode(Bool.self, forKey: .isSensitive)
            visibility = try container.decode(Visibility.self, forKey: .visibility)
            pinned = try container.decodeIfPresent(Bool.self, forKey: .pinned)
            emojis = try container.decode([Emoji].self, forKey: .emojis)
            repliesCount = try container.decode(Int.self, forKey: .repliesCount)
            poll = try container.decodeIfPresent(Poll.self, forKey: .poll)
            isBookmarked = try container.decode(Bool.self, forKey: .isBookmarked)
        }
    }
}
