import Foundation

/// Represents an OAuth token used for authenticating with the API and performing actions.
public struct Token: Codable {
    /// An OAuth token to be used for authorization.
    ///
    /// Added in 0.1.0
    public let accessToken: String

    /// The OAuth token type. Mastodon uses `Bearer` tokens.
    ///
    /// Added in 0.1.0
    public let tokenType: String

    /// The OAuth scopes granted by this token, space-separated.
    ///
    /// Added in 0.1.0
    public let scope: String

    /// When the token was generated.
    ///
    /// Added in 0.1.0
    public let createdAt: TimeInterval
}

extension Token {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
}
