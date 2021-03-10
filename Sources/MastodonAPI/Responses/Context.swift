extension Responses {
    public struct Context: Decodable {
        public let ancestors: [Status]
        public let descendants: [Status]
    }
}
