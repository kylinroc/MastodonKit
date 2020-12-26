import Foundation

extension Responses {
    public struct Token {
        public let accessToken: String
        public let tokenType: String
        public let scope: String
        public let creationDate: Date
    }
}

extension Responses.Token: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case creationDate = "created_at"
    }
}