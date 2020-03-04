import Foundation

/// Represents the software instance of Mastodon running on this domain.
public struct Server: Codable {
    /// The domain name of the instance.
    ///
    /// Added in 1.1.0
    public let uri: String

    /// The title of the website.
    ///
    /// Added in 1.1.0
    public let title: String

    /// Admin-defined description of the Mastodon site.
    ///
    /// Added in 1.1.0
    public let description: String

    /// An email that may be contacted for any inquiries.
    ///
    /// Added in 1.1.0
    public let email: String

    /// The version of Mastodon installed on the instance.
    ///
    /// Added in 1.3.0
    public let version: String

    /// URLs of interest for clients apps.
    ///
    /// Added in 1.4.2
    public let urls: [String: URL]

    /// Statistics about how much information the instance contains.
    ///
    /// Added in 1.6.0
    public let stats: [String: Int]

    /// Banner image for the website.
    ///
    /// Added in 1.6.1
    public let thumbnail: URL?

    /// Primary langauges of the website and its staff.
    ///
    /// Added in 2.3.0
    public let languages: [String]

    /// A user that can be contacted, as an alternative to `email`.
    ///
    /// Added in 2.3.0
    public let contactAccount: Account?

    /// Whether registrations are enabled.
    ///
    /// Added in 2.7.2
    public let registrations: Bool

    /// A shorter description defined by the admin.
    ///
    /// Added in 2.9.2
    public let shortDescription: String

    /// Whether registrations require moderator approval.
    ///
    /// Added in 2.9.2
    public let approvalRequired: Bool
}
