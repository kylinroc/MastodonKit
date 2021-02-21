import Foundation

extension Responses {
    public struct Poll: Decodable {
        public struct Option: Decodable {
            public let title: String
            public let votesCount: Int

            private enum CodingKeys: String, CodingKey {
                case title
                case votesCount = "votes_count"
            }
        }

        public let id: String
        public let expiresDate: Date
        public let options: [Option]

        private enum CodingKeys: String, CodingKey {
            case id
            case expiresDate = "expires_at"
            case options
        }
    }
}
