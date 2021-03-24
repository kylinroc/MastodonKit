import Foundation

extension Requests.API.V1 {
    public struct Accounts {
        private let id: String

        public init(_ id: String) {
            self.id = id
        }
    }
}

extension Requests.API.V1.Accounts {
    public static func verifyCredentials() -> Request<Responses.Account> {
        Request(path: "/api/v1/accounts/verify_credentials", httpMethod: .get)
    }

    public static func relationships(ids: [String]) -> Request<[Responses.Relationship]> {
        Request(path: "/api/v1/accounts/relationships", httpMethod: .get(ids.map {
            URLQueryItem(name: "id[]", value: $0)
        }))
    }
}

extension Requests.API.V1.Accounts {
    public func statuses(
        pinned: Bool? = nil,
        excludeReplies: Bool? = nil,
        onlyMedia: Bool? = nil,
        maxID: String? = nil,
        minID: String? = nil
    ) -> Request<Paginated<[Responses.Status]>> {
        var queryItems: [URLQueryItem] = []
        if let pinned = pinned {
            queryItems.append(URLQueryItem(name: "pinned", value: "\(pinned)"))
        }
        if let excludeReplies = excludeReplies {
            queryItems.append(URLQueryItem(name: "exclude_replies", value: "\(excludeReplies)"))
        }
        if let onlyMedia = onlyMedia {
            queryItems.append(URLQueryItem(name: "only_media", value: "\(onlyMedia)"))
        }
        if let maxID = maxID {
            queryItems.append(URLQueryItem(name: "max_id", value: maxID))
        }
        if let minID = minID {
            queryItems.append(URLQueryItem(name: "min_id", value: minID))
        }
        return Request(path: "/api/v1/accounts/\(id)/statuses", httpMethod: .get(queryItems))
    }

    public func followers(
        maxID: String? = nil,
        minID: String? = nil,
        limit: Int? = nil
    ) -> Request<Paginated<[Responses.Account]>> {
        var queryItems: [URLQueryItem] = []
        if let maxID = maxID {
            queryItems.append(URLQueryItem(name: "max_id", value: maxID))
        }
        if let minID = minID {
            queryItems.append(URLQueryItem(name: "min_id", value: minID))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        return Request(path: "/api/v1/accounts/\(id)/followers", httpMethod: .get(queryItems))
    }

    public func following(
        maxID: String? = nil,
        minID: String? = nil,
        limit: Int? = nil
    ) -> Request<Paginated<[Responses.Account]>> {
        var queryItems: [URLQueryItem] = []
        if let maxID = maxID {
            queryItems.append(URLQueryItem(name: "max_id", value: maxID))
        }
        if let minID = minID {
            queryItems.append(URLQueryItem(name: "min_id", value: minID))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        return Request(path: "/api/v1/accounts/\(id)/following", httpMethod: .get(queryItems))
    }

    public func identityProofs() -> Request<[Responses.IdentityProof]> {
        Request(path: "/api/v1/accounts/\(id)/identity_proofs", httpMethod: .get)
    }

    public func follow() -> Request<Responses.Relationship> {
        Request(path: "/api/v1/accounts/\(id)/follow", httpMethod: .post)
    }

    public func unfollow() -> Request<Responses.Relationship> {
        Request(path: "/api/v1/accounts/\(id)/unfollow", httpMethod: .post)
    }
}
