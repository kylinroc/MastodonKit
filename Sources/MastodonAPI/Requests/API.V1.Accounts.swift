import Foundation
import HTTPLinkHeader

extension Requests.API.V1 {
    public struct Accounts {
        private let id: String

        public init(_ id: String) {
            self.id = id
        }
    }
}

extension Requests.API.V1.Accounts {
    public static func relationships(ids: [String]) -> Request<[Responses.Relationship]> {
        Request(path: "/api/v1/accounts/relationships", httpMethod: .get(ids.map {
            URLQueryItem(name: "id[]", value: $0)
        }))
    }

    public static func verifyCredentials() -> Request<Responses.Account> {
        Request(path: "/api/v1/accounts/verify_credentials", httpMethod: .get(nil))
    }
}

extension Requests.API.V1.Accounts {
    public func followers(pagination: HTTPLinkHeader? = nil) -> Request<Paged<[Responses.Account]>> {
        let queryItems: [URLQueryItem]?
        if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
            queryItems = urlComponents.queryItems
        } else {
            queryItems = nil
        }

        return Request(path: "/api/v1/accounts/\(id)/followers", httpMethod: .get(queryItems))
    }

    public func following(pagination: HTTPLinkHeader? = nil) -> Request<Paged<[Responses.Account]>> {
        let queryItems: [URLQueryItem]?
        if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
            queryItems = urlComponents.queryItems
        } else {
            queryItems = nil
        }

        return Request(path: "/api/v1/accounts/\(id)/following", httpMethod: .get(queryItems))
    }

    public func identityProofs() -> Request<[Responses.IdentityProof]> {
        Request(path: "/api/v1/accounts/\(id)/identity_proofs", httpMethod: .get(nil))
    }

    public func statuses(
        pinned: Bool? = nil,
        excludeReplies: Bool? = nil,
        onlyMedia: Bool? = nil,
        pagination: HTTPLinkHeader? = nil
    ) -> Request<Paged<[Responses.Status]>> {
        var queryItems: [URLQueryItem]?
        if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
            queryItems = urlComponents.queryItems
        } else {
            queryItems = []
            if let pinned = pinned {
                queryItems?.append(URLQueryItem(name: "pinned", value: "\(pinned)"))
            }
            if let excludeReplies = excludeReplies {
                queryItems?.append(URLQueryItem(name: "exclude_replies", value: "\(excludeReplies)"))
            }
            if let onlyMedia = onlyMedia {
                queryItems?.append(URLQueryItem(name: "only_media", value: "\(onlyMedia)"))
            }
        }

        return Request(path: "/api/v1/accounts/\(id)/statuses", httpMethod: .get(queryItems))
    }
}
