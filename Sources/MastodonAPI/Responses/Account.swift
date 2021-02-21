import Foundation

extension Responses {
    public struct Account: Decodable {
        public let id: String
        public let username: String
        public let fullUsername: String
        public let displayName: String
        public let staticAvatarURL: URL
        public let staticHeaderURL: URL
        public let statusesCount: Int
        public let followingCount: Int
        public let followersCount: Int

        private enum CodingKeys: String, CodingKey {
            case id
            case username
            case fullUsername = "acct"
            case displayName = "display_name"
            case staticAvatarURL = "avatar_static"
            case staticHeaderURL = "header_static"
            case statusesCount = "statuses_count"
            case followingCount = "following_count"
            case followersCount = "followers_count"
        }
    }
}
