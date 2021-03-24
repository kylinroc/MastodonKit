import Foundation
import HTTPLinkHeader

extension Requests.API {
    public enum V1 {
        public static func accounts(id: String) -> Request<Responses.Account> {
            Request(path: "/api/v1/accounts/\(id)", httpMethod: .get)
        }

        public static func apps(
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
            return Request(path: "/api/v1/apps", httpMethod: .post(httpBody))
        }

        public static func bookmarks(pagination: HTTPLinkHeader? = nil) -> Request<Paginated<[Responses.Status]>> {
            let queryItems: [URLQueryItem]?
            if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
                queryItems = urlComponents.queryItems
            } else {
                queryItems = nil
            }

            return Request(path: "/api/v1/bookmarks", httpMethod: .get(queryItems))
        }


        public static func conversations(pagination: HTTPLinkHeader?) -> Request<Paginated<[Responses.Conversation]>> {
            let queryItems: [URLQueryItem]?
            if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
                queryItems = urlComponents.queryItems
            } else {
                queryItems = nil
            }

            return Request(path: "/api/v1/conversations", httpMethod: .get(queryItems))
        }

        public static func favourites(pagination: HTTPLinkHeader? = nil) -> Request<Paginated<[Responses.Status]>> {
            let queryItems: [URLQueryItem]?
            if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
                queryItems = urlComponents.queryItems
            } else {
                queryItems = nil
            }

            return Request(path: "/api/v1/favourites", httpMethod: .get(queryItems))
        }

        public static func notifications(
            pagination: HTTPLinkHeader? = nil
        ) -> Request<Paginated<[Responses.Notification]>> {
            let queryItems: [URLQueryItem]?
            if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
                queryItems = urlComponents.queryItems
            } else {
                queryItems = nil
            }

            return Request(path: "/api/v1/notifications", httpMethod: .get(queryItems))
        }
    }
}
