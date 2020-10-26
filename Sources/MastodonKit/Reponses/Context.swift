extension Responses {
    public struct Context: Codable {
        public let ancestors: [Toot]
        public let descendants: [Toot]
    }
}
