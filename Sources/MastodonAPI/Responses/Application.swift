extension Responses {
    public struct Application: Decodable {
        public let id: String
        public let name: String
        public let website: String?
        public let redirectURI: String
        public let clientID: String
        public let clientSecret: String
        public let vapidKey: String

        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case website
            case redirectURI = "redirect_uri"
            case clientID = "client_id"
            case clientSecret = "client_secret"
            case vapidKey = "vapid_key"
        }
    }
}
