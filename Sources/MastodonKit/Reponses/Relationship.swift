extension Responses {
    public struct Relationship: Codable {
        public let id: String
        public let following: Bool
        public let followedBy: Bool
        public let isBlocked: Bool
        public let isRequested: Bool
        public let isMuted: Bool
        public let domainBlocking: Bool
        public let mutingNotifications: Bool
        public let showingReblogs: Bool
        public let endorsed: Bool
        public let blockedBy: Bool
    }
}

extension Responses.Relationship {
    private enum CodingKeys: String, CodingKey {
        case id
        case following
        case followedBy = "followed_by"
        case isBlocked = "blocking"
        case isRequested = "requested"
        case isMuted = "muting"
        case domainBlocking = "domain_blocking"
        case mutingNotifications = "muting_notifications"
        case showingReblogs = "showing_reblogs"
        case endorsed
        case blockedBy = "blocked_by"
    }
}
