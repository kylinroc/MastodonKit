import Foundation

/// Represents a poll attached to a toot.
public struct Poll: Codable {
    /// The ID of the poll in the database.
    ///
    /// Added in 2.8.0
    public let id: String

    /// When the poll ends.
    ///
    /// Added in 2.8.0
    public let expiresDate: Date?

    /// Is the poll currently expired?
    ///
    /// Added in 2.8.0
    public let expired: Bool

    /// Does the poll allow multiple-choice answers?
    ///
    /// Added in 2.8.0
    public let multiple: Bool

    /// How many votes have been received.
    ///
    /// Added in 2.8.0
    public let votesCount: Int

    /// How many unique accounts have voted on a multiple-choice poll.
    ///
    /// Added in 2.8.0
    public let votersCount: Int?

    /// When called with a user token, has the authorized user voted?
    ///
    /// Added in 2.8.0
    public let voted: Bool?

    /// When called with a user token, which options has the authorized user chosen? Contains an array of index values for `options`.
    ///
    /// Added in 2.8.0
    public let ownVotes: [Int]?

    /// Possible answers for the poll.
    ///
    /// Added in 2.8.0
    public let options: [Option]

    /// Custom emoji to be used for rendering poll options.
    ///
    /// Added in 2.8.0
    public let emojis: [Emoji]
}

extension Poll {
    private enum CodingKeys: String, CodingKey {
        case id
        case expiresDate = "expires_at"
        case expired
        case multiple
        case votesCount = "votes_count"
        case votersCount = "voters_count"
        case voted
        case ownVotes = "own_votes"
        case options
        case emojis
    }
}
