import Foundation

extension Responses {
    public struct Token: Decodable {
        public let accessToken: String
        public let creationDate: Date
        public let scope: String
        public let tokenType: String
    }
}

extension Responses.Token {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case creationDate = "created_at"
        case scope
        case tokenType = "token_type"
    }
}
