import Foundation

extension Responses {
    public enum AttachmentType: String, Decodable {
        // 0.6.0
        case unknown
        // 0.6.0
        case image
        // 0.6.0
        case gifv
        // 0.6.0
        case video
        // 2.9.1
        case audio
    }

    public struct AttachmentMetadata: Decodable {}

    public struct Attachment: Decodable {
        // 0.6.0
        public let id: String

        // 0.6.0
        public let type: AttachmentType

        // 0.6.0
        public let url: URL

        // 0.6.0
        public let previewURL: URL?

        // 0.6.0
        public let remoteURL: URL?

        // 0.6.0
        public let textURL: URL?

        // 1.5.0
        public let metadata: AttachmentMetadata?

        // 2.0.0
        public let description: String?

        // 2.8.1
        public let blurhash: String?

        private enum CodingKeys: String, CodingKey {
            case id
            case type
            case url
            case previewURL = "preview_url"
            case remoteURL = "remote_url"
            case textURL = "text_url"
            case metadata = "meta"
            case description
            case blurhash
        }
    }
}
