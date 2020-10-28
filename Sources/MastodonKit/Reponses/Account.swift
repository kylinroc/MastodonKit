import Foundation

extension Responses {
    public final class Account: Codable {
        public let avatarURL: URL
        public let bio: String
        public let creationDate: Date
        public let displayName: String
        public let emojis: [Emoji]
        public let followersCount: Int
        public let followingCount: Int
        public let fullUsername: String
        public let headerURL: URL
        public let id: String
        public let isLocked: Bool
        public let staticAvatarURL: URL
        public let staticHeaderURL: URL
        public let tootsCount: Int
        public let url: URL
        public let username: String

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            avatarURL = try container.decode(URL.self, forKey: .avatarURL)
            bio = try container.decode(String.self, forKey: .bio)
            creationDate = try container.decode(Date.self, forKey: .creationDate)
            username = try container.decode(String.self, forKey: .username)
            if let displayName = try container.decodeIfPresent(String.self, forKey: .displayName),
               displayName.isEmpty == false {
                self.displayName = displayName
            } else {
                self.displayName = username
            }
            emojis = try container.decode([Emoji].self, forKey: .emojis)
            followersCount = try container.decode(Int.self, forKey: .followersCount)
            followingCount = try container.decode(Int.self, forKey: .followingCount)
            fullUsername = try container.decode(String.self, forKey: .fullUsername)
            headerURL = try container.decode(URL.self, forKey: .headerURL)
            id = try container.decode(String.self, forKey: .id)
            isLocked = try container.decode(Bool.self, forKey: .isLocked)
            staticAvatarURL = try container.decode(URL.self, forKey: .staticAvatarURL)
            staticHeaderURL = try container.decode(URL.self, forKey: .staticHeaderURL)
            tootsCount = try container.decode(Int.self, forKey: .tootsCount)
            url = try container.decode(URL.self, forKey: .url)
        }
    }
}

extension Responses.Account {
    private enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar"
        case bio = "note"
        case creationDate = "created_at"
        case displayName = "display_name"
        case emojis
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case fullUsername = "acct"
        case headerURL = "header"
        case id
        case isLocked = "locked"
        case staticAvatarURL = "avatar_static"
        case staticHeaderURL = "header_static"
        case tootsCount = "statuses_count"
        case url
        case username
    }
}
