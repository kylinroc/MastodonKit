import Foundation

/// Represents a hashtag used within the content of a status.
public struct Tag: Codable {
    /// The value of the hashtag after the # sign.
    ///
    /// Added in 0.9.0
    public var name: String

    /// A link to the hashtag on the instance.
    ///
    /// Added in 0.9.0
    public var url: URL

    /// Usage statistics for given days.
    ///
    /// Added in 2.4.1
    public var history: [History] { _history ?? [] }

    private var _history: [History]?
}

extension Tag {
    private enum CodingKeys: String, CodingKey {
        case name
        case url
        case _history = "history"
    }
}
