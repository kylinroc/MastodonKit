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
        return Request(path: "/api/v1/apps", httpMethod: .post, httpBody: httpBody)
    }
}
