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

    public func statuses(pinned: Bool) -> Request<Paged<[Responses.Status]>> {
        Request(path: "/api/v1/accounts/\(id)/statuses", httpMethod: .get([
            URLQueryItem(name: "pinned", value: "\(pinned)")
        ]))
    }

    public func identityProofs() -> Request<[Responses.IdentityProof]> {
        Request(path: "/api/v1/accounts/\(id)/identity_proofs", httpMethod: .get(nil))
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
}
