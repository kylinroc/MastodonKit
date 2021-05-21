extension Responses {
    public struct Relationship: Decodable {
        // 0.6.0
        public let id: String

        // 0.6.0
        public let following: Bool

        // 0.6.0
        public let followedBy: Bool

        // 0.6.0
        public let blocking: Bool

        // 0.9.9
        public let requested: Bool

        // 1.1.0
        public let muting: Bool

        // 1.4.0
        public let domainBlocking: Bool

        // 2.1.0
        public let mutingNotifications: Bool

        // 2.1.0
        public let showingReblogs: Bool

        // 2.5.0
        public let endorsed: Bool

        // 2.8.0
        public let blockedBy: Bool

        // 3.2.0
        public let note: String

        // 3.3.0
        public let notifying: Bool

        private enum CodingKeys: String, CodingKey {
            case id
            case following
            case followedBy = "followed_by"
            case blocking
            case requested
            case muting
            case domainBlocking = "domain_blocking"
            case mutingNotifications = "muting_notifications"
            case showingReblogs = "showing_reblogs"
            case endorsed
            case blockedBy = "blocked_by"
            case note
            case notifying
        }
    }
}
