import Foundation

extension Responses {
    public struct Emoji: Codable, Hashable {
        public let shortcode: String
        public let staticURL: URL

        private enum CodingKeys: String, CodingKey {
            case shortcode
            case staticURL = "static_url"
        }
    }
}
