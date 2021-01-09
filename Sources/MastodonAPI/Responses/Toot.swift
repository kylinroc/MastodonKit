import Foundation

extension Responses {
    public final class Toot: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case account
            case content
            case creationDate = "created_at"
            case boostedToot = "reblog"
        }

        public let id: String
        public let account: Account
        public let content: String
        public let creationDate: Date
        public let boostedToot: Toot?
    }
}
