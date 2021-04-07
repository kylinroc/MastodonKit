extension Responses {
    public enum NotificationType: String, Decodable {
        case follow
        case followRequest = "follow_request"
        case mention
        case reblog
        case favorite = "favourite"
        case poll
        case status
    }

    public struct Notification: Decodable {
        public let id: String
        public let type: NotificationType
        public let account: Account
        public let status: Status?

        private enum CodingKeys: String, CodingKey {
            case id
            case type
            case account
            case status
        }
    }
}
