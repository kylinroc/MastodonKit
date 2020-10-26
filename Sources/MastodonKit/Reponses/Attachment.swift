import Foundation

extension Responses {
    public enum AttachmentType: String, Codable {
        case unknown
        case image
        case gifv
        case video
        case audio
    }

    public struct Attachment: Codable {
        public let id: String
        public let previewURL: URL?
        public let remoteURL: URL?
        public let textURL: URL?
        public let type: AttachmentType
        public let url: URL
    }
}

extension Responses.Attachment {
    private enum CodingKeys: String, CodingKey {
        case id
        case previewURL = "preview_url"
        case remoteURL = "remote_url"
        case textURL = "text_url"
        case type
        case url
    }
}
