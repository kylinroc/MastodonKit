extension Responses {
    public struct Application: Decodable {
        public let clientID: String?
        public let clientSecret: String?
        public let id: String
        public let name: String
        public let redirectURI: String
        public let vapidKey: String?
        public let website: String?
    }
}

extension Responses.Application {
    private enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case id
        case name
        case redirectURI = "redirect_uri"
        case vapidKey = "vapid_key"
        case website
    }
}
