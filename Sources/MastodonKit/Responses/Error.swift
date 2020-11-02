extension Responses {
    public struct Error {
        public let failureReason: String
        public let errorDescription: String
    }
}

extension Responses.Error: Decodable {
    private enum CodingKeys: String, CodingKey {
        case failureReason = "error"
        case errorDescription = "error_description"
    }
}

extension Responses.Error: Error {}
