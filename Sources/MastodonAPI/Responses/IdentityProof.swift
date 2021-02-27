import Foundation

extension Responses {
    public struct IdentityProof: Decodable {
        // 2.8.0
        public let provider: String

        // 2.8.0
        public let providerUsername: String

        // 2.8.0
        public let profileURL: URL

        // 2.8.0
        public let proofURL: URL

        // 2.8.0
        public let updateDate: Date

        private enum CodingKeys: String, CodingKey {
            case provider
            case providerUsername = "provider_username"
            case profileURL = "profile_url"
            case proofURL = "proof_url"
            case updateDate = "updated_at"
        }
    }
}
