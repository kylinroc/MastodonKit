import Foundation

/// Represents the software instance of Mastodon running on this domain.
public struct Instance: Codable {
    /// The domain name of the instance.
    ///
    /// Added in 1.1.0
    public var uri: String

    /// The title of the website.
    ///
    /// Added in 1.1.0
    public var title: String

    /// Admin-defined description of the Mastodon site.
    ///
    /// Added in 1.1.0
    public var description: String

    /// A shorter description defined by the admin.
    ///
    /// Added in 2.9.2
    public var shortDescription: String

    /// An email that may be contacted for any inquiries.
    ///
    /// Added in 1.1.0
    public var email: String

    /// The version of Mastodon installed on the instance.
    ///
    /// Added in 1.3.0
    public var version: String

    /// Primary langauges of the website and its staff.
    ///
    /// Added in 2.3.0
    public var languages: [String]

    /// Whether registrations are enabled.
    ///
    /// Added in 2.7.2
    public var registrations: Bool

    /// Whether registrations require moderator approval.
    ///
    /// Added in 2.9.2
    public var approvalRequired: Bool

    /// Banner image for the website.
    ///
    /// Added in 1.6.1
    public var thumbnail: URL?
}
