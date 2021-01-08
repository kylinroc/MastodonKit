import Foundation

extension Responses {
    public struct Account {
        public let fullUsername: String
        public let displayName: String
        public let staticAvatarURL: URL
    }
}

extension Responses.Account: Decodable {
    private enum CodingKeys: String, CodingKey {
        case fullUsername = "acct"
        case displayName = "display_name"
        case staticAvatarURL = "avatar_static"
    }
}
