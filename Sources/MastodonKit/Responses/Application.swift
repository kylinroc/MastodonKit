extension Responses {
    public struct Application {
        public let name: String
        public let website: String?
        public let id: String
        public let clientID: String?
        public let clientSecret: String?
        public let redirectURI: String
        public let vapidKey: String?
    }
}

extension Responses.Application: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case website
        case id
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case redirectURI = "redirect_uri"
        case vapidKey = "vapid_key"
    }
}
