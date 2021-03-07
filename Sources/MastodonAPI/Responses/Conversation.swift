extension Responses {
    public struct Conversation: Decodable {
        public let id: String
        public let accounts: [Account]
        public let isUnread: Bool
        public let lastStatus: Status?

        private enum CodingKeys: String, CodingKey {
            case id
            case accounts
            case isUnread = "unread"
            case lastStatus = "last_status"
        }
    }
}
