extension Responses {
    public enum NotificationType: String, Decodable {
        case follow
        case followRequest = "follow_request"
        case mention
        case boost = "reblog"
        case favorite = "favourite"
        case poll
        case toot = "status"
    }

    public struct Notification: Decodable {
        public let id: String
        public let type: NotificationType
        public let toot: Toot?

        private enum CodingKeys: String, CodingKey {
            case id
            case type
            case toot = "status"
        }
    }
}
