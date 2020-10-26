public enum NotificationType: String, Decodable {
    case follow
    case mention
    case boost = "reblog"

    /// Someone favourited one of your statuses
    ///
    /// Added in 0.9.9
    case favorite = "favourite"

    /// A poll you have voted in or created has ended.
    ///
    /// Added in 2.8.0
    case poll
}

extension Responses {
    /// Represents a notification of an event relevant to the user.
    public struct Notification: Decodable {
        /// The id of the notification in the database.
        ///
        /// Added in 0.9.9
        public let id: String

        /// The type of event that resulted in the notification.
        ///
        /// Added in 0.9.9
        public let type: NotificationType

        /// The timestamp of the notification.
        ///
        /// Added in 0.9.9
        public let createdAt: String

        /// The account that performed the action that generated the notification.
        ///
        /// Added in 0.9.9
        public let account: Account

        /// Status that was the object of the notification, e.g. in mentions, reblogs, favourites, or polls.
        ///
        /// Added in 0.9.9
        public let toot: Toot?
    }
}

extension Responses.Notification {
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case createdAt = "created_at"
        case account
        case toot = "status"
    }
}
