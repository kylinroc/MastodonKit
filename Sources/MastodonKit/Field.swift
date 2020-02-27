import Foundation

/// Represents a profile field as a name-value pair with optional verification.
public struct Field: Codable {
    /// The key of a given field's key-value pair.
    ///
    /// Added in 2.4.0
    public var name: String

    /// The value associated with the `name` key.
    ///
    /// Added in 2.4.0
    public var value: String

    /// Timestamp of when the server verified a URL value for a rel="me” link.
    ///
    /// Added in 2.6.0
    public var verifiedAt: Date?
}

extension Field {
    private enum CodingKeys: String, CodingKey {
        case name
        case value
        case verifiedAt = "verified_at"
    }
}
