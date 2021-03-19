import Foundation

extension Responses {
    public struct Tag: Decodable {
        public let name: String
        public let url: URL
    }
}
