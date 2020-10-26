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

extension Responses.Application {
    public func obtainToken(authorizationCode: String, scopes: [Scope]) -> Request<Responses.Token> {
        Request(path: "/oauth/token", httpMethod: .post, parameters: [
            "client_id": clientID!,
            "client_secret": clientSecret!,
            "redirect_uri": redirectURI!,
            "scope": scopes.map(\.rawValue).joined(separator: " "),
            "code": authorizationCode,
            "grant_type": "authorization_code",
        ])
    }
}
