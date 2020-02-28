import Foundation

/// Represents an application that interfaces with the REST API to access accounts or post statuses.
public struct Application: Codable {
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

extension Application {
    private enum CodingKeys: String, CodingKey {
        case name
        case website
        case clientID = "client_id"
        case clientSecret = "client_secret"
        case vapidKey = "vapid_key"
        case redirectURI = "redirect_uri"
    }
}

extension Application {
    public static func create(
        name: String,
        redirectURI: String = "urn:ietf:wg:oauth:2.0:oob"
    ) -> Request<Application> {
        Request(path: "/api/v1/apps", httpMethod: .post, parameters: [
            "client_name": name,
            "redirect_uris": redirectURI,
        ])
    }

    public func obtainToken(authorizationCode: String) -> Request<Token> {
        Request(path: "/oauth/token", httpMethod: .post, parameters: [
            "client_id": clientID!,
            "client_secret": clientSecret!,
            "redirect_uri": redirectURI!,
            "code": authorizationCode,
            "grant_type": "authorization_code",
        ])
    }
}
