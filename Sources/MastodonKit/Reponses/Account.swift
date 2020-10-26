import Foundation

extension Responses {
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
        public let fullUsername: String

        /// The location of the user's profile page.
        ///
        /// Added in 0.1.0
        public let url: URL

        /// The profile's display name.
        ///
        /// Added in 0.1.0
        public var displayName: String { _displayName.isEmpty ? username : _displayName }
        private let _displayName: String

        /// The profile's bio / description.
        ///
        /// Added in 0.1.0
        public let note: String

        /// An image icon that is shown next to toots and in the profile.
        ///
        /// Added in 0.1.0
        public let avatarURL: URL

        /// An image banner that is shown above the profile and in profile cards.
        ///
        /// Added in 0.1.0
        public let headerURL: URL

        /// Whether the account manually approves follow requests.
        ///
        /// Added in 0.1.0
        public let isLocked: Bool

        /// When the account was created.
        ///
        /// Added in 0.1.0
        public let creationDate: Date

        /// How many toots are attached to this account.
        ///
        /// Added in 0.1.0
        public let tootsCount: Int

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
        public let staticHeaderURL: URL

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
        public let metadata: [Metadata]

        /// A presentational flag. Indicates that the account may perform automated actions, may not be monitored, or identifies as a robot.
        ///
        /// Added in 2.4.0
        public let isBot: Bool

        /// An extra entity to be used with API methods to [verify credentials]() and [update credentials]().
        ///
        /// Added in 2.4.0
        public let source: Source?
    }
}

extension Responses.Account {
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case fullUsername = "acct"
        case url
        case _displayName = "display_name"
        case note
        case avatarURL = "avatar"
        case headerURL = "header"
        case isLocked = "locked"
        case creationDate = "created_at"
        case tootsCount = "statuses_count"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case staticAvatarURL = "avatar_static"
        case staticHeaderURL = "header_static"
        case moved
        case emojis
        case metadata = "fields"
        case isBot = "bot"
        case source
    }
}

extension Responses.Account: Equatable {
    public static func == (lhs: Responses.Account, rhs: Responses.Account) -> Bool {
        lhs.id == rhs.id
    }
}

extension Responses.Account: Hashable {
    public func hash(into hasher: inout Hasher) {
        id.hash(into: &hasher)
    }
}
