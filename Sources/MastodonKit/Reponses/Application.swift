import Foundation

extension Responses {
    /// Represents an application that interfaces with the REST API to access accounts or post toots.
    public struct Application: Codable {
        private enum CodingKeys: String, CodingKey {
            case name
            case website
            case clientID = "client_id"
            case clientSecret = "client_secret"
            case vapidKey = "vapid_key"
            case redirectURI = "redirect_uri"
        }

        /// The name of your application.
        ///
        /// Added in 0.9.9
        public let name: String

        /// The website associated with your application.
        ///
        /// Added in 0.9.9
        public let website: String?

        /// Client ID key, to be used for obtaining OAuth tokens.
        ///
        /// Added in 0.9.9
        public let clientID: String?

        /// Client secret key, to be used for obtaining OAuth tokens.
        ///
        /// Added in 0.9.9
        public let clientSecret: String?

        /// Used for Push Streaming API.
        ///
        /// Added in 2.8.0
        public let vapidKey: String?

        public let redirectURI: String?
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
