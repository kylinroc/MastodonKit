import Foundation

extension Responses {
    public struct Mention: Codable {
        public let id: String
        public let username: String
        public let acct: String
        public let url: URL
    }
}
