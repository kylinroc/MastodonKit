import Foundation

extension Requests {
    public enum OAuth {
        public static func token(
            clientID: String,
            clientSecret: String,
            redirectURI: String,
            scopes: [Scope] = [.read],
            code: String
        ) -> Request<Responses.Token> {
            struct Parameters: Encodable {
                private enum CodingKeys: String, CodingKey {
                    case clientID = "client_id"
                    case clientSecret = "client_secret"
                    case redirectURI = "redirect_uri"
                    case scopes = "scope"
                    case code
                    case grantType = "grant_type"
                }

                let clientID: String
                let clientSecret: String
                let redirectURI: String
                let scopes: String
                let code: String
                let grantType: String
            }

            let parameters = Parameters(
                clientID: clientID,
                clientSecret: clientSecret,
                redirectURI: redirectURI,
                scopes: scopes.map(\.rawValue).joined(separator: " "),
                code: code,
                grantType: "authorization_code"
            )
            let httpBody = try? JSONEncoder().encode(parameters)
            return Request(path: "/oauth/token", httpMethod: .post(httpBody))
        }
    }
}
