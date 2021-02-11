extension Responses {
    public struct Notification: Decodable {
        public let id: String
        public let toot: Toot?

        private enum CodingKeys: String, CodingKey {
            case id
            case toot = "status"
        }
    }
}
