import Foundation

extension Responses {
    public struct Token {
        let accessToken: String
        let tokenType: String
        let scope: String
        let creationDate: Date
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
