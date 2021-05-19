extension Responses {
    public struct Results: Decodable {
        public let accounts: [Account]
        public let statuses: [Status]
        public let hashtags: [Tag]
    }
}
