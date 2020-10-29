extension Responses {
    public struct Token: Codable {
        let accessToken: String
        let tokenType: String
        let scope: String
        let createdAt: Double
    }
}
