extension Responses {
    public struct Application: Decodable {
        let clientID: String?
        let clientSecret: String?
        let id: String
        let name: String
        let redirectURI: String
        let vapidKey: String?
        let website: String?
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
