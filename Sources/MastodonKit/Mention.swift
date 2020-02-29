import Foundation

/// Represents a mention of a user within the content of a toot.
public struct Mention: Codable {
    /// The account id of the mentioned user.
    ///
    /// Added in 0.6.0
    public let id: String

    /// The username of the mentioned user.
    ///
    /// Added in 0.6.0
    public let username: String

    /// The webfinger acct: URI of the mentioned user. Equivalent to `username` for local users, or `username@domain` for remote users.
    ///
    /// Added in 0.6.0
    public let acct: String

    /// The location of the mentioned user's profile.
    ///
    /// Added in 0.6.0
    public let url: URL
}
