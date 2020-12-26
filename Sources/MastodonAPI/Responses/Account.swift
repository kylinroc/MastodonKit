import Foundation

extension Responses {
    public struct Account {
        public let staticAvatarURL: URL
    }
}

extension Responses.Account: Decodable {
    private enum CodingKeys: String, CodingKey {
        case staticAvatarURL = "avatar_static"
    }
}
