extension Responses {
    public struct Relationship: Decodable {
        // 0.6.0
        public let id: String

        // 0.6.0
        public let isFollowing: Bool

        // 0.6.0
        public let isFollowedBy: Bool

        // 0.6.0
        public let isBlocking: Bool

        // 0.9.9
        public let requested: Bool

        // 1.1.0
        public let isMuting: Bool

        // 1.4.0
        public let isDomainBlocking: Bool

        // 2.1.0
        public let isMutingNotifications: Bool

        // 2.1.0
        public let isShowingReblogs: Bool

        // 2.5.0
        public let endorsed: Bool

        // 2.8.0
        public let isBlockedBy: Bool

        // 3.2.0
        public let note: String

        // 3.3.0
        public let isNotifying: Bool

        private enum CodingKeys: String, CodingKey {
            case id
            case isFollowing = "following"
            case isFollowedBy = "followed_by"
            case isBlocking = "blocking"
            case requested
            case isMuting = "muting"
            case isDomainBlocking = "domain_blocking"
            case isMutingNotifications = "muting_notifications"
            case isShowingReblogs = "showing_reblogs"
            case endorsed
            case isBlockedBy = "blocked_by"
            case note
            case isNotifying = "notifying"
        }
    }
}
