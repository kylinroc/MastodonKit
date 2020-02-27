import Foundation

/// Represents a custom emoji.
public struct Emoji: Codable {
    /// The name of the custom emoji.
    ///
    /// Added in 2.0.0
    public let shortcode: String

    /// A link to the custom emoji.
    ///
    /// Added in 2.0.0
    public let url: URL

    /// A link to a static copy of the custom emoji.
    ///
    /// Added in 2.0.0
    public let staticURL: URL

    /// Whether this Emoji should be visible in the picker or unlisted.
    ///
    /// Added in 2.0.0
    public let visibleInPicker: Bool

    /// Used for sorting custom emoji in the picker.
    ///
    /// Added in 3.0.0
    public let category: String?
}

extension Emoji {
    private enum CodingKeys: String, CodingKey {
        case shortcode
        case url
        case staticURL = "static_url"
        case visibleInPicker = "visible_in_picker"
        case category
    }
}
