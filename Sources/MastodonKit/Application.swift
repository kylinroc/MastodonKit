import Foundation

extension Mastodon {
    public struct Application: Codable {
        /// The name of your application.
        ///
        /// Added in 0.9.9
        public var name: String

        /// The website associated with your application.
        ///
        /// Added in 0.9.9
        public var website: URL?

        /// Client ID key, to be used for obtaining OAuth tokens.
        ///
        /// Added in 0.9.9
        public var clientID: String

        /// Client secret key, to be used for obtaining OAuth tokens.
        ///
        /// Added in 0.9.9
        public var clientSecret: String

        /// Used for Push Streaming API.
        ///
        /// Added in 2.8.0
        public var vapidKey: String?

        private enum CodingKeys: String, CodingKey {
            case name
            case website
            case clientID = "client_id"
            case clientSecret = "client_secret"
            case vapidKey = "vapid_key"
        }
    }
}

extension Mastodon.Application {
    public static func create(
        clientName: String,
        redirectURIs: String = "urn:ietf:wg:oauth:2.0:oob"
    ) -> Mastodon.Client.Request<Mastodon.Application> {
        return Mastodon.Client.Request(method: "POST", path: "apps", parameters: [
            "client_name": clientName,
            "redirect_uris": redirectURIs,
        ])
    }
}
