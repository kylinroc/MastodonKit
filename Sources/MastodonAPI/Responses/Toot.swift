extension Responses {
    public final class Toot: Decodable {
        private enum CodingKeys: String, CodingKey {
            case account
            case boostedToot = "reblog"
        }

        public let account: Account
        public let boostedToot: Toot?
    }
}
