import Foundation

extension Responses {
    public enum AttachmentType: String, Decodable {
        /// Unsupported or unrecognized file type.
        ///
        /// Added in 0.6.0.
        case unknown

        /// Static image.
        ///
        /// Added in 0.6.0.
        case image

        /// Looping, soundless animation.
        ///
        /// Added in 0.6.0.
        case gifv

        /// Video clip.
        ///
        /// Added in 0.6.0.
        case video

        /// Audio track.
        ///
        /// Added in 2.9.1.
        case audio

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = AttachmentType(rawValue: rawValue) ?? .unknown
        }
    }

    public struct Attachment: Decodable {
        /// The ID of the attachment in the database.
        ///
        /// Added in 0.6.0.
        public let id: String

        /// The type of the attachment.
        ///
        /// Added in 0.6.0.
        public let type: AttachmentType

        /// The location of the original full-size attachment.
        ///
        /// Added in 0.6.0.
        public let url: URL

        /// The location of a scaled-down preview of the attachment.
        ///
        /// Added in 0.6.0.
        public let previewURL: URL?

        /// The location of the full-size original attachment on the remote website.
        ///
        /// Added in 0.6.0.
        public let remoteURL: URL?

        /// A shorter URL for the attachment.
        ///
        /// Added in 0.6.0.
        public let textURL: URL?

        /// Alternate text that describes what is in the media attachment, to be used for the visually impaired or when media attachments do not load.
        ///
        /// Added in 2.0.0.
        public let description: String?

        /// A hash computed by [the BlurHash algorithm](https://github.com/woltapp/blurhash),
        /// for generating colorful preview thumbnails when media has not been downloaded yet.
        ///
        /// Added in 2.8.1.
        public let blurhash: String?

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
}
