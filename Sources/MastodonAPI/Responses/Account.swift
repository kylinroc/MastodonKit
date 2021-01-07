import Foundation

extension Responses {
    public struct Account {
        public let displayName: String
        public let staticAvatarURL: URL
    }
}

extension Responses.Account: Decodable {
    private enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case staticAvatarURL = "avatar_static"
    }
}
