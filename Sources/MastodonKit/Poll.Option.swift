extension Poll {
    public struct Option: Codable {
        /// The text value of the poll option.
        ///
        /// Added in 2.8.0
        public var title: String

        /// The number of received votes for this option.
        ///
        /// Added in 2.8.0
        public var votesCount: Int?
    }
}

extension Poll.Option {
    private enum CodingKeys: String, CodingKey {
        case title
        case votesCount = "votes_count"
    }
}
