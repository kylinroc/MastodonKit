import Foundation

/// Represents a status posted by an account.
public final class Status: Codable {
    public enum Visibility: String, Codable {
        case `public`
        case unlisted
        case `private`
        case direct
    }

    /// ID of the status in the database.
    ///
    /// Added in 0.1.0
    public let id: String

    /// URI of the status used for federation.
    ///
    /// Added in 0.1.0
    public let uri: String

    /// The date when this status was created.
    ///
    /// Added in 0.1.0
    public let createdAt: Date

    /// The account that authored this status.
    ///
    /// Added in 0.1.0
    public let account: Account

    /// HTML-encoded status content.
    ///
    /// Added in 0.1.0
    public let content: String

    /// How many boosts this status has received.
    ///
    /// Added in 0.1.0
    public let reblogsCount: Int

    /// How many favourites this status has received.
    ///
    /// Added in 0.1.0
    public let favouritesCount: Int

    /// A link to the status's HTML representation.
    ///
    /// Added in 0.1.0
    public let url: URL?

    /// ID of the status being replied.
    ///
    /// Added in 0.1.0
    public let inReplyToID: String?

    /// The status being reblogged.
    ///
    /// Added in 0.1.0
    public let reblog: Status?

    /// Have you favourited this status?
    ///
    /// Added in 0.1.0
    public let favourited: Bool?

    /// Have you boosted this status?
    ///
    /// Added in 0.1.0
    public let reblogged: Bool?

    /// Media that is attached to this status.
    ///
    /// Added in 0.6.0
    public let mediaAttachments: [Attachment]

    /// Mentions of users within the status content.
    ///
    /// Added in 0.6.0
    public let mentions: [Mention]

    /// Hashtags used within the status content.
    ///
    /// Added in 0.9.0
    public let tags: [Tag]

    /// Visibility of this status.
    ///
    /// Added in 0.9.9
    public let visibility: Visibility

    /// Is this status marked as sensitive content?
    ///
    /// Added in 0.9.9
    public let sensitive: Bool

    /// The application used to post this status.
    ///
    /// Added in 0.9.9
    public let application: Application?

    /// Subject or summary line, below which status content is collapsed until expanded.
    ///
    /// Added in 1.0.0
    public let spoilerText: String

    /// ID of the account being replied to.
    ///
    /// Added in 1.0.0
    public let inReplyToAccountID: String?

    /// Primary language of this status
    ///
    /// Added in 1.4.0
    public let language: String?

    /// Have you muted notifications for this status's conversation?
    ///
    /// Added in 1.4.0
    public let muted: Bool?

    /// Have you pinned this status? Only appears if the status is pinnable.
    ///
    /// Added in 1.6.0
    public let pinned: Bool?

    /// Custom emoji to be used when rendering status content.
    ///
    /// Added in 2.0.0
    public let emojis: [Emoji]

    /// How many replies this status has received.
    ///
    /// Added in 2.5.0
    public let repliesCount: Int

    /// Preview card for links included within status content.
    ///
    /// Added in 2.6.0
    public let card: Card?

    /// The poll attached to the status.
    ///
    /// Added in 2.8.0
    public let poll: Poll?

    /// Have you bookmarked this status?
    ///
    /// Added in 3.1.0
    public let bookmarked: Bool?
}

extension Status {
    private enum CodingKeys: String, CodingKey {
        case id
        case uri
        case createdAt = "created_at"
        case account
        case content
        case reblogsCount = "reblogs_count"
        case favouritesCount = "favourites_count"
        case url
        case inReplyToID = "in_reply_to_id"
        case reblog
        case favourited
        case reblogged
        case mediaAttachments = "media_attachments"
        case mentions
        case tags
        case visibility
        case sensitive
        case application
        case spoilerText = "spoiler_text"
        case inReplyToAccountID = "in_reply_to_account_id"
        case language
        case muted
        case pinned
        case emojis
        case repliesCount = "replies_count"
        case card
        case poll
        case bookmarked
    }
}
