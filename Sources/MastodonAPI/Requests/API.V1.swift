import Foundation

extension Requests.API {
    public enum V1 {}
}

extension Requests.API.V1 {
    public static func accounts(id: String) -> Request<Responses.Account> {
        Request(path: "/api/v1/accounts/\(id)", httpMethod: .get)
    }

    public static func apps(
        clientName: String,
        redirectURIs: String = "urn:ietf:wg:oauth:2.0:oob",
        scopes: [Scope]? = nil,
        website: String? = nil
    ) -> Request<Responses.Application> {
        struct Parameters: Encodable {
            private enum CodingKeys: String, CodingKey {
                case clientName = "client_name"
                case redirectURIs = "redirect_uris"
                case scopes
                case website
            }

            let clientName: String
            let redirectURIs: String
            let scopes: String?
            let website: String?
        }

        let parameters = Parameters(
            clientName: clientName,
            redirectURIs: redirectURIs,
            scopes: scopes?.map(\.rawValue).joined(separator: " "),
            website: website
        )
        let httpBody = try? JSONEncoder().encode(parameters)
        return Request(path: "/api/v1/apps", httpMethod: .post(httpBody))
    }

    public static func bookmarks(
        limit: Int? = nil,
        maxID: String? = nil,
        sinceID: String? = nil,
        minID: String? = nil
    ) -> Request<Paginated<[Responses.Status]>> {
        var queryItems: [URLQueryItem] = []
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        if let maxID = maxID {
            queryItems.append(URLQueryItem(name: "max_id", value: maxID))
        }
        if let sinceID = sinceID {
            queryItems.append(URLQueryItem(name: "since_id", value: sinceID))
        }
        if let minID = minID {
            queryItems.append(URLQueryItem(name: "min_id", value: minID))
        }
        return Request(path: "/api/v1/bookmarks", httpMethod: .get(queryItems))
    }

    public static func favourites(
        limit: Int? = nil,
        maxID: String? = nil,
        minID: String? = nil
    ) -> Request<Paginated<[Responses.Status]>> {
        var queryItems: [URLQueryItem] = []
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        if let maxID = maxID {
            queryItems.append(URLQueryItem(name: "max_id", value: maxID))
        }
        if let minID = minID {
            queryItems.append(URLQueryItem(name: "min_id", value: minID))
        }
        return Request(path: "/api/v1/favourites", httpMethod: .get(queryItems))
    }

    public static func notifications(
        maxID: String? = nil,
        sinceID: String? = nil,
        minID: String? = nil,
        limit: Int? = nil
    ) -> Request<Paginated<[Responses.Notification]>> {
        var queryItems: [URLQueryItem] = []
        if let maxID = maxID {
            queryItems.append(URLQueryItem(name: "max_id", value: maxID))
        }
        if let sinceID = sinceID {
            queryItems.append(URLQueryItem(name: "since_id", value: sinceID))
        }
        if let minID = minID {
            queryItems.append(URLQueryItem(name: "min_id", value: minID))
        }
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        return Request(path: "/api/v1/notifications", httpMethod: .get(queryItems))
    }

    public static func statuses(id: String) -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)", httpMethod: .get)
    }

    public static func statuses(status: String, inReplyToID: String?) -> Request<Responses.Status> {
        struct Parameters: Encodable {
            let status: String
            let inReplyToID: String?

            enum CodingKeys: String, CodingKey {
                case status
                case inReplyToID = "in_reply_to_id"
            }
        }

        let parameters = Parameters(status: status, inReplyToID: inReplyToID)
        let httpBody = try? JSONEncoder().encode(parameters)
        return Request(path: "/api/v1/statuses", httpMethod: .post(httpBody))
    }

    public static func trends(limit: Int? = nil) -> Request<[Responses.Tag]> {
        var queryItems: [URLQueryItem] = []
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        return Request(path: "/api/v1/trends", httpMethod: .get(queryItems))
    }
}
