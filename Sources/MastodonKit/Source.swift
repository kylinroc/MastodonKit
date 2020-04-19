/// Represents display or publishing preferences of user's own account.
///
/// Returned as an additional entity when verifying and updated credentials, as an attribute of `Account`.
public struct Source: Codable {
    public enum Privacy: String, Codable {
        case `public`
        case unlisted
        case `private`
        case direct
    }

    /// Profile bio.
    ///
    /// Added in 1.5.0
    public let note: String

    /// The default post privacy to be used for new toots.
    ///
    /// Added in 1.5.0
    public let privacy: Privacy?

    /// Whether new toots should be marked sensitive by default.
    ///
    /// Added in 1.5.0
    public let sensitive: Bool

    /// Metadata about the account.
    ///
    /// Added in 2.4.0
    public let fields: [Field]

    /// The default posting language for new toots.
    ///
    /// Added in 2.4.2
    public let language: String?

    /// The number of pending follow requests.
    ///
    /// Added in 3.0.0
    public let followRequestsCount: Int?
}

extension Source {
    private enum CodingKeys: String, CodingKey {
        case note
        case privacy
        case sensitive
        case fields
        case language
        case followRequestsCount = "follow_requests_count"
    }
}
