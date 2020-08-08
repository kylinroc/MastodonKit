import Foundation

public enum CardType: String, Decodable {
    case link
    case photo
    case video
    case rich
}

/// Represents a rich preview card that is generated using OpenGraph tags from a URL.
public struct Card: Decodable {
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
    public let authorURL: URL?

    /// The provider of the original resource.
    ///
    /// Added in 1.3.0
    public let providerName: String?

    /// A link to the provider of the original resource.
    ///
    /// Added in 1.3.0
    public let providerURL: URL?

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
    public var embedURL: URL?
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
        case embedURL = "embed_url"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decode(URL.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        image = try container.decodeIfPresent(URL.self, forKey: .image)
        type = try container.decode(CardType.self, forKey: .type)
        authorName = try container.decodeIfPresent(String.self, forKey: .authorName)
        if let string = try container.decodeIfPresent(String.self, forKey: .authorURL) {
            authorURL = URL(string: string)
        } else {
            authorURL = nil
        }
        providerName = try container.decodeIfPresent(String.self, forKey: .providerName)
        if let string = try container.decodeIfPresent(String.self, forKey: .providerURL) {
            providerURL = URL(string: string)
        } else {
            providerURL = nil
        }
        html = try container.decodeIfPresent(String.self, forKey: .html)
        width = try container.decodeIfPresent(Double.self, forKey: .width)
        height = try container.decodeIfPresent(Double.self, forKey: .height)
        if let string = try container.decodeIfPresent(String.self, forKey: .embedURL) {
            embedURL = URL(string: string)
        } else {
            embedURL = nil
        }
    }
}
