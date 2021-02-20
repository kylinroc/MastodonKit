import Foundation

extension Responses {
    public struct Account: Decodable {
        public let id: String
        public let username: String
        public let fullUsername: String
        public let displayName: String
        public let staticAvatarURL: URL

        private enum CodingKeys: String, CodingKey {
            case id
            case username
            case fullUsername = "acct"
            case displayName = "display_name"
            case staticAvatarURL = "avatar_static"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            username = try container.decode(String.self, forKey: .username)
            fullUsername = try container.decode(String.self, forKey: .fullUsername)
            if let displayName = try container.decodeIfPresent(String.self, forKey: .displayName),
               !displayName.isEmpty {
                self.displayName = displayName
            } else {
                self.displayName = username
            }
            staticAvatarURL = try container.decode(URL.self, forKey: .staticAvatarURL)
        }
    }
}
