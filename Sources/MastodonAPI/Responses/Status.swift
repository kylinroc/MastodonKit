import Foundation

extension Responses {
    public final class Status: Decodable {
        // 0.1.0
        public let id: String

        // 0.1.0
        public let account: Account

        // 0.1.0
        public let spoilerText: String

        // 0.1.0
        public let content: String

        // 0.1.0
        public let createdAt: Date

        // 0.1.0
        public let reblogged: Bool

        // 0.1.0
        public let favourited: Bool

        // 0.1.0
        public let reblogsCount: Int

        // 0.1.0
        public let favoritesCount: Int

        // 0.1.0
        public let reblog: Status?

        // 0.1.0
        public let inReplyToID: String?

        // 0.1.0
        public let url: URL?

        // 0.6.0
        public let mediaAttachments: [Attachment]

        // 0.6.0
        public let mentions: [Mention]

        // 0.9.0
        public let tags: [Tag]

        // 0.9.9
        public let sensitive: Bool

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
        public let bookmarked: Bool

        // MARK: Decodable

        private enum CodingKeys: String, CodingKey {
            case id
            case account
            case spoilerText = "spoiler_text"
            case content
            case createdAt = "created_at"
            case reblogged
            case favourited
            case reblogsCount = "reblogs_count"
            case favoritesCount = "favourites_count"
            case reblog
            case inReplyToID = "in_reply_to_id"
            case url
            case mediaAttachments = "media_attachments"
            case mentions
            case tags
            case sensitive
            case visibility
            case pinned
            case emojis
            case repliesCount = "replies_count"
            case poll
            case bookmarked
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            account = try container.decode(Account.self, forKey: .account)
            spoilerText = try container.decode(String.self, forKey: .spoilerText)
            content = try container.decode(String.self, forKey: .content)
            createdAt = try container.decode(Date.self, forKey: .createdAt)
            reblogged = try container.decode(Bool.self, forKey: .reblogged)
            favourited = try container.decode(Bool.self, forKey: .favourited)
            reblogsCount = try container.decode(Int.self, forKey: .reblogsCount)
            favoritesCount = try container.decode(Int.self, forKey: .favoritesCount)
            reblog = try container.decodeIfPresent(Status.self, forKey: .reblog)
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

            mediaAttachments = try container.decode([Attachment].self, forKey: .mediaAttachments)
            mentions = try container.decode([Mention].self, forKey: .mentions)
            tags = try container.decode([Tag].self, forKey: .tags)
            sensitive = try container.decode(Bool.self, forKey: .sensitive)
            visibility = try container.decode(Visibility.self, forKey: .visibility)
            pinned = try container.decodeIfPresent(Bool.self, forKey: .pinned)
            emojis = try container.decode([Emoji].self, forKey: .emojis)
            repliesCount = try container.decode(Int.self, forKey: .repliesCount)
            poll = try container.decodeIfPresent(Poll.self, forKey: .poll)
            bookmarked = try container.decode(Bool.self, forKey: .bookmarked)
        }
    }
}
