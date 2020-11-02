import Foundation

public enum Requests {
    public static func registerApplication(
        name: String,
        redirectURI: String = "urn:ietf:wg:oauth:2.0:oob",
        scopes: [Scope] = [.read],
        website: String? = nil
    ) -> Request<Responses.Application> {
        struct Parameters: Encodable {
            private enum CodingKeys: String, CodingKey {
                case name = "client_name"
                case redirectURI = "redirect_uris"
                case scopes
                case website
            }

            let name: String
            let redirectURI: String
            let scopes: String
            let website: String?
        }

        let parameters = Parameters(
            name: name,
            redirectURI: redirectURI,
            scopes: scopes.map(\.rawValue).joined(separator: " "),
            website: website
        )
        let httpBody = try? JSONEncoder().encode(parameters)
        return Request(path: "/api/v1/apps", httpBody: httpBody, httpMethod: .post)
    }

    public static func obtainToken(
        clientID: String,
        clientSecret: String,
        redirectURI: String,
        scopes: [Scope] = [.read]
    ) -> Request<Responses.Token> {
        struct Parameters: Encodable {
            private enum CodingKeys: String, CodingKey {
                case clientID = "client_id"
                case clientSecret = "client_secret"
                case redirectURI = "redirect_uri"
                case scope
                case grantType = "grant_type"
            }

            let clientID: String
            let clientSecret: String
            let redirectURI: String
            let scope: String
            let grantType = "client_credentials"
        }
        let parameters = Parameters(
            clientID: clientID,
            clientSecret: clientSecret,
            redirectURI: redirectURI,
            scope: scopes.map(\.rawValue).joined(separator: " ")
        )
        let httpBody = try? JSONEncoder().encode(parameters)
        return Request(path: "/oauth/token", httpBody: httpBody, httpMethod: .post)
    }
}
