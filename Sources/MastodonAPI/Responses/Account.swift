import Foundation

extension Responses {
    public struct Account: Decodable {
        // 0.1.0
        public let id: String

        // 0.1.0
        public let username: String

        // 0.1.0
        public let usernameAtDomain: String

        // 0.1.0
        public let url: URL

        // 0.1.0
        public let displayName: String

        // 0.1.0
        public let note: String

        // 0.1.0
        public let statusesCount: Int

        // 0.1.0
        public let followingCount: Int

        // 0.1.0
        public let followersCount: Int

        // 1.1.2
        public let staticAvatarURL: URL

        // 1.1.2
        public let staticHeaderURL: URL

        // 2.4.0
        public let emojis: [Emoji]

        // 2.4.0
        public let fields: [Field]

        private enum CodingKeys: String, CodingKey {
            case id
            case username
            case usernameAtDomain = "acct"
            case url
            case displayName = "display_name"
            case note
            case statusesCount = "statuses_count"
            case followingCount = "following_count"
            case followersCount = "followers_count"
            case staticAvatarURL = "avatar_static"
            case staticHeaderURL = "header_static"
            case emojis
            case fields
        }
    }
}
