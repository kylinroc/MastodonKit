import Foundation

extension Responses {
    public struct Field: Codable, Hashable {
        // 2.4.0
        public let name: String

        // 2.4.0
        public let value: String

        // 2.4.0
        public let verificationDate: Date?

        private enum CodingKeys: String, CodingKey {
            case name
            case value
            case verificationDate = "verified_at"
        }
    }
}
