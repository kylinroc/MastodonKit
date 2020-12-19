extension Responses {
    public struct Error {
        public let reason: String
        public let description: String?
    }
}

extension Responses.Error: Decodable {
    private enum CodingKeys: String, CodingKey {
        case reason = "error"
        case description = "error_description"
    }
}

extension Responses.Error: Error {}
