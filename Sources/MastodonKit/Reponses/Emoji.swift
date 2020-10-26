import Foundation

extension Responses {
    public struct Emoji: Codable {
        public let shortcode: String
        public let staticURL: URL
        public let url: URL
    }
}

extension Responses.Emoji {
    private enum CodingKeys: String, CodingKey {
        case shortcode
        case staticURL = "static_url"
        case url
    }
}
