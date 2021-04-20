import Foundation

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

    public func rebloggedBy(maxID: String? = nil, minID: String? = nil) -> Request<Paginated<[Responses.Account]>> {
        var queryItems: [URLQueryItem] = []
        if let maxID = maxID {
            queryItems.append(URLQueryItem(name: "max_id", value: maxID))
        }
        if let minID = minID {
            queryItems.append(URLQueryItem(name: "min_id", value: minID))
        }
        return Request(path: "/api/v1/statuses/\(id)/reblogged_by", httpMethod: .get(queryItems))
    }

    public func favouritedBy(maxID: String? = nil, minID: String? = nil) -> Request<Paginated<[Responses.Account]>> {
        var queryItems: [URLQueryItem] = []
        if let maxID = maxID {
            queryItems.append(URLQueryItem(name: "max_id", value: maxID))
        }
        if let minID = minID {
            queryItems.append(URLQueryItem(name: "min_id", value: minID))
        }
        return Request(path: "/api/v1/statuses/\(id)/favourited_by", httpMethod: .get(queryItems))
    }

    public func favourite() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/favourite", httpMethod: .post)
    }

    public func unfavourite() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/unfavourite", httpMethod: .post)
    }

    public func reblog() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/reblog", httpMethod: .post)
    }

    public func unreblog() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/unreblog", httpMethod: .post)
    }

    public func bookmark() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/bookmark", httpMethod: .post)
    }

    public func unbookmark() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/unbookmark", httpMethod: .post)
    }

    public func pin() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/pin", httpMethod: .post)
    }

    public func unpin() -> Request<Responses.Status> {
        Request(path: "/api/v1/statuses/\(id)/unpin", httpMethod: .post)
    }
}
