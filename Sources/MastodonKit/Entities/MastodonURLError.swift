/// Represents an error message.
public struct MastodonURLError: Codable, Error {
    /// The error message.
    ///
    /// Added in 0.6.0
    public var error: String

    /// A longer description of the error, mainly provided with the OAuth API.
    ///
    /// Added in 0.6.0
    public var errorDescription: String?
}
