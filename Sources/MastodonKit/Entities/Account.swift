import Foundation

/// Represents a user of Mastodon and their associated profile.
public final class Account: Codable {
    /// The account id.
    ///
    /// Added in 0.1.0
    public let id: String

    /// The username of the account, not including domain.
    ///
    /// Added in 0.1.0
    public let username: String

    /// The Webfinger account URI. Equal to `username` for local users, or `username@domain` for remote users.
    ///
    /// Added in 0.1.0
    public let acct: String

    /// The location of the user's profile page.
    ///
    /// Added in 0.1.0
    public let url: URL

    /// The profile's display name.
    ///
    /// Added in 0.1.0
    public let displayName: String

    /// The profile's bio / description.
    ///
    /// Added in 0.1.0
    public let note: String

    /// An image icon that is shown next to statuses and in the profile.
    ///
    /// Added in 0.1.0
    public let avatarURL: URL

    /// An image banner that is shown above the profile and in profile cards.
    ///
    /// Added in 0.1.0
    public let header: URL

    /// Whether the account manually approves follow requests.
    ///
    /// Added in 0.1.0
    public let locked: Bool

    /// When the account was created.
    ///
    /// Added in 0.1.0
    public let createdAt: Date

    /// How many statuses are attached to this account.
    ///
    /// Added in 0.1.0
    public let statusesCount: Int

    /// The reported followers of this profile.
    ///
    /// Added in 0.1.0
    public let followersCount: Int

    /// The reported follows of this profile.
    ///
    /// Added in 0.1.0
    public let followingCount: Int

    /// A static version of the avatar.
    ///
    /// Equal to `avatarURL` if its value is a static image; different if `avatarURL` is an animated GIF.
    ///
    /// Added in 1.1.2
    public let staticAvatarURL: URL

    /// A static version of the header. Equal to `header` if its value is a static image; different if `header` is an animated GIF.
    ///
    /// Added in 1.1.2
    public let headerStatic: URL

    /// Indicates that the profile is currently inactive and that its user has moved to a new account.
    ///
    /// Added in 2.1.0
    public let moved: Account?

    /// Custom emoji entities to be used when rendering the profile. If none, an empty array will be returned.
    ///
    /// Added in 2.4.0
    public let emojis: [Emoji]

    /// Additional metadata attached to a profile as name-value pairs.
    ///
    /// Added in 2.4.0
    public let fields: [Field]

    /// A presentational flag. Indicates that the account may perform automated actions, may not be monitored, or identifies as a robot.
    ///
    /// Added in 2.4.0
    public let bot: Bool

    /// An extra entity to be used with API methods to [verify credentials]() and [update credentials]().
    ///
    /// Added in 2.4.0
    public let source: Source?

    /// Whether the account has opted into discovery features such as the profile directory.
    ///
    /// Added in 3.1.0
    public var discoverable: Bool { _discoverable ?? false }

    private let _discoverable: Bool?
}

extension Account {
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case acct
        case url
        case displayName = "display_name"
        case note
        case avatarURL = "avatar"
        case header
        case locked
        case createdAt = "created_at"
        case statusesCount = "statuses_count"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case staticAvatarURL = "avatar_static"
        case headerStatic = "header_static"
        case moved
        case emojis
        case fields
        case bot
        case source
        case _discoverable
    }
}
