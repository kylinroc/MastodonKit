import Foundation

public enum AttachmentType: String, Codable {
    /// Unsupported or unrecognized file type.
    ///
    /// Added in 0.6.0
    case unknown

    /// Static image.
    ///
    /// Added in 0.6.0
    case image

    /// Looping, soundless animation.
    ///
    /// Added in 0.6.0
    case gifv

    /// Video clip.
    ///
    /// Added in 0.6.0
    case video

    /// Audio track.
    ///
    /// Added in 2.9.1
    case audio
}

/// Represents a file or media attachment that can be added to a status.
public struct Attachment: Codable {
    /// The ID of the attachment in the database.
    ///
    /// Added in 0.6.0.
    public let id: String

    /// The type of the attachment.
    ///
    /// Added in 0.6.0
    public let type: AttachmentType

    /// The location of the original full-size attachment.
    ///
    /// Added in 0.6.0
    public let url: URL

    /// The location of a scaled-down preview of the attachment.
    ///
    /// Added in 0.6.0
    public let previewURL: URL

    /// The location of the full-size original attachment on the remote website.
    ///
    /// Added in 0.6.0.
    public let remoteURL: URL?

    /// A shorter URL for the attachment.
    ///
    /// Added in 0.6.0
    public let textURL: URL?

    /// Metadata returned by Paperclip.
    ///
    /// May contain subtrees `small` and `original`, as well as various other top-level properties.
    ///
    /// More importantly, there may be another top-level `focus` Hash object as of 2.3.0,
    /// with coordinates can be used for smart thumbnail cropping - see Focal points for more.
    ///
    /// Added in 1.5.0. meta[focus] added in 2.3.0.
    // public let meta: [String: Any]

    /// Alternate text that describes what is in the media attachment, to be used for the visually impaired or when media attachments do not load.
    ///
    /// Added in 2.0.0
    public let description: String?

    /// A hash computed by [the BlurHash algorithm](https://github.com/woltapp/blurhash),
    /// for generating colorful preview thumbnails when media has not been downloaded yet.
    ///
    /// Added in 2.8.1
    public let blurhash: String?
}

extension Attachment {
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case url
        case previewURL = "preview_url"
        case remoteURL = "remote_url"
        case textURL = "text_url"
        case description
        case blurhash
    }
}
