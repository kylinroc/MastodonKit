import Foundation
import HTTPLinkHeader

extension Requests.API.V1 {
    public struct Statuses {
        private let id: String

        public init(_ id: String) {
            self.id = id
        }
    }
}

extension Requests.API.V1.Statuses {
    public func context() -> Request<Responses.Context> {
        Request(path: "/api/v1/statuses/\(id)/context", httpMethod: .get)
    }

    public func reblog() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/reblog", httpMethod: .post)
    }

    public func unreblog() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/unreblog", httpMethod: .post)
    }

    public func favourite() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/favourite", httpMethod: .post)
    }

    public func unfavourite() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/unfavourite", httpMethod: .post)
    }

    public func bookmark() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/bookmark", httpMethod: .post)
    }

    public func unbookmark() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/unbookmark", httpMethod: .post)
    }

    public func rebloggedBy(pagination: HTTPLinkHeader? = nil) -> Request<Paginated<[Responses.Account]>> {
        let queryItems: [URLQueryItem]?
        if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
            queryItems = urlComponents.queryItems
        } else {
            queryItems = nil
        }

        return Request(path: "/api/v1/statuses/\(id)/reblogged_by", httpMethod: .get(queryItems))
    }

    public func favouritedBy(pagination: HTTPLinkHeader? = nil) -> Request<Paginated<[Responses.Account]>> {
        let queryItems: [URLQueryItem]?
        if let pagination = pagination, let urlComponents = URLComponents(string: pagination.uriReference) {
            queryItems = urlComponents.queryItems
        } else {
            queryItems = nil
        }

        return Request(path: "/api/v1/statuses/\(id)/favourited_by", httpMethod: .get(queryItems))
    }
}
