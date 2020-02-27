import Foundation

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
    public let url: URL

    /// Title of linked resource.
    ///
    /// Added in 1.0.0
    public let title: String

    /// Description of preview.
    ///
    /// Added in 1.0.0
    public let description: String

    /// Preview thumbnail.
    ///
    /// Added in 1.0.0
    public let image: URL?

    /// The type of the preview card.
    ///
    /// Added in 1.3.0
    public let type: CardType

    /// The author of the original resource.
    ///
    /// Added in 1.3.0
    public let authorName: String?

    /// A link to the author of the original resource.
    ///
    /// Added in 1.3.0
    public var authorURL: URL? { URL(string: _authorURL) }
    private let _authorURL: String?

    /// The provider of the original resource.
    ///
    /// Added in 1.3.0
    public let providerName: String?

    /// A link to the provider of the original resource.
    ///
    /// Added in 1.3.0
    public var providerURL: URL? { URL(string: _providerURL) }
    private let _providerURL: String?

    /// HTML to be used for generating the preview card.
    ///
    /// Added in 1.3.0
    public let html: String?

    /// Width of preview, in pixels.
    ///
    /// Added in 1.3.0
    public let width: Double?

    /// Height of preview, in pixels.
    ///
    /// Added in 1.3.0
    public let height: Double?

    /// Used for photo embeds, instead of custom `html`.
    ///
    /// Added in 2.1.0
    public var embedURL: URL? { URL(string: _embedURL) }
    private let _embedURL: String?
}

extension Card {
    private enum CodingKeys: String, CodingKey {
        case url
        case title
        case description
        case image
        case type
        case authorName = "author_name"
        case _authorURL = "author_url"
        case providerName = "provider_name"
        case _providerURL = "provider_url"
        case html
        case width
        case height
        case _embedURL = "embed_url"
    }
}
