import Foundation

/// Type of Card.
public enum CardType: String, Codable {
    case link
    case photo
    case video
    case rich
}

/// Represents a rich preview card that is generated using OpenGraph tags from a URL.
public struct Card: Codable {
    /// Location of linked resource.
    ///
    /// Added in 1.0.0
    public var url: URL

    /// Title of linked resource.
    ///
    /// Added in 1.0.0
    public var title: String

    /// Description of preview.
    ///
    /// Added in 1.0.0
    public var description: String

    /// Preview thumbnail.
    ///
    /// Added in 1.0.0
    public var image: URL?

    /// The type of the preview card.
    ///
    /// Added in 1.3.0
    public var type: CardType

    /// The author of the original resource.
    ///
    /// Added in 1.3.0
    public var authorName: String?

    /// A link to the author of the original resource.
    ///
    /// Added in 1.3.0
    public var authorURL: URL?

    /// The provider of the original resource.
    ///
    /// Added in 1.3.0
    public var providerName: String?

    /// A link to the provider of the original resource.
    ///
    /// Added in 1.3.0
    public var providerURL: URL?

    /// HTML to be used for generating the preview card.
    ///
    /// Added in 1.3.0
    public var html: String?

    /// Width of preview, in pixels.
    ///
    /// Added in 1.3.0
    public var width: Double?

    /// Height of preview, in pixels.
    ///
    /// Added in 1.3.0
    public var height: Double?

    /// Used for photo embeds, instead of custom `html`.
    ///
    /// Added in 2.1.0
    public var embedURL: URL? {
        if let _embedURL = _embedURL {
            return URL(string: _embedURL)
        } else {
            return nil
        }
    }

    private var _embedURL: String?
}

extension Card {
    private enum CodingKeys: String, CodingKey {
        case url
        case title
        case description
        case image
        case type
        case authorName = "author_name"
        case authorURL = "author_url"
        case providerName = "provider_name"
        case providerURL = "provider_url"
        case html
        case width
        case height
        case _embedURL = "embed_url"
    }
}
