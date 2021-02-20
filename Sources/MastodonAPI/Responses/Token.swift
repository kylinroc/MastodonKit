import Foundation

extension Responses {
    public struct Token: Decodable {
        public let accessToken: String
        public let tokenType: String
        public let scope: String

        private enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case tokenType = "token_type"
            case scope
        }
    }
}
