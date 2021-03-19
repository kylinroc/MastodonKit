import Foundation

extension Responses {
    public struct Mention: Decodable {
        public let id: String
        public let username: String
        public let acct: String
        public let url: URL
    }
}
