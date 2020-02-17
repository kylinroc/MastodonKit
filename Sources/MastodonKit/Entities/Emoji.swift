import Foundation

/// Represents a custom emoji.
public struct Emoji: Codable {
    /// The name of the custom emoji.
    ///
    /// Added in 2.0.0
    public var shortcode: String

    /// A link to the custom emoji.
    ///
    /// Added in 2.0.0
    public var url: URL

    /// A link to a static copy of the custom emoji.
    ///
    /// Added in 2.0.0
    public var staticURL: URL

    /// Whether this Emoji should be visible in the picker or unlisted.
    ///
    /// Added in 2.0.0
    public var visibleInPicker: Bool

    /// Used for sorting custom emoji in the picker.
    ///
    /// Added in 3.0.0
    public var category: String?
}
