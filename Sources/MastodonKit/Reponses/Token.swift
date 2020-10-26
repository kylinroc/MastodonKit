import Foundation

extension Responses {
    public struct Token: Codable, Equatable {
        public let accessToken: String
        public let createdAt: TimeInterval
        public let scope: String
        public let tokenType: String
    }
}

extension Responses.Token {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case createdAt = "created_at"
        case scope
        case tokenType = "token_type"
    }
}
