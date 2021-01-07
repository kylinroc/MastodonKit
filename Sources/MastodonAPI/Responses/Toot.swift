extension Responses {
    public final class Toot: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case account
            case boostedToot = "reblog"
        }

        public let id: String
        public let account: Account
        public let boostedToot: Toot?
    }
}
