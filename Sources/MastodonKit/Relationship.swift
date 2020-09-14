/// Represents the relationship between accounts.
public struct Relationship: Codable {
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
    }

    /// The account id.
    ///
    /// Added in 0.6.0
    public let id: String

    /// Are you following this user?
    ///
    /// Added in 0.6.0
    public let following: Bool

    /// Are you followed by this user?
    ///
    /// Added in 0.6.0
    public let followedBy: Bool

    /// Are you blocking this user?
    ///
    /// Added in 0.6.0
    public let blocking: Bool

    /// Do you have a pending follow request for this user?
    ///
    /// Added in 0.9.9
    public let requested: Bool

    /// Are you muting this user?
    ///
    /// Added in 1.1.0
    public let muting: Bool

    /// Are you blocking this user's domain?
    ///
    /// Added in 1.4.0
    public let domainBlocking: Bool

    /// Are you muting notifications from this user?
    ///
    /// Added in 2.1.0
    public let mutingNotifications: Bool

    /// Are you receiving this user's boosts in your home timeline?
    ///
    /// Added in 2.1.0
    public let showingReblogs: Bool

    /// Are you featuring this user on your profile?
    ///
    /// Added in 2.5.0
    public let endorsed: Bool

    /// Is this user blocking you?
    ///
    /// Added in 2.8.0
    public let blockedBy: Bool
}
