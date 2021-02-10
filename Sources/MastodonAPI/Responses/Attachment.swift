import Foundation

extension Responses {
    public struct Attachment: Decodable {
        public let id: String
        public let previewURL: URL

        private enum CodingKeys: String, CodingKey {
            case id
            case previewURL = "preview_url"
        }
    }
}
