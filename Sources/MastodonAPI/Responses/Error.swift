extension Responses {
    public struct Error: Decodable, Swift.Error {
        public let reason: String
        public let description: String?

        private enum CodingKeys: String, CodingKey {
            case reason = "error"
            case description = "error_description"
        }
    }
}
