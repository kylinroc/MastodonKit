import Foundation

extension Responses {
    public struct Application: Codable {
        public let clientID: String?
        public let clientSecret: String?
        public let name: String
        public let redirectURI: String?
        public let website: String?
    }
}

extension Responses.Application {
    private enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case name
        case redirectURI = "redirect_uri"
        case website
    }
}
