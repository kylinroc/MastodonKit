import Foundation

extension Requests.API.V1 {
    public enum Timelines {}
}

extension Requests.API.V1.Timelines {
    public static func `public`(
        local: Bool? = nil,
        remote: Bool? = nil,
        onlyMedia: Bool? = nil,
        maxID: String? = nil,
        sinceID: String? = nil,
        minID: String? = nil,
        limit: Int? = nil
    ) -> Request<Paginated<[Responses.Status]>> {
        var queryItems: [URLQueryItem] = []
        if let local = local {
            queryItems.append(URLQueryItem(name: "local", value: "\(local)"))
        }
        if let remote = remote {
            queryItems.append(URLQueryItem(name: "remote", value: "\(remote)"))
        }
        if let onlyMedia = onlyMedia {
            queryItems.append(URLQueryItem(name: "only_media", value: "\(onlyMedia)"))
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
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        return Request(path: "/api/v1/timelines/public", httpMethod: .get(queryItems))
    }

    public static func tag(
        hashtag: String,
        local: Bool? = nil,
        onlyMedia: Bool? = nil,
        maxID: String? = nil,
        sinceID: String? = nil,
        minID: String? = nil,
        limit: Int? = nil
    ) -> Request<Paginated<[Responses.Status]>> {
        var queryItems: [URLQueryItem] = []
        if let local = local {
            queryItems.append(URLQueryItem(name: "local", value: "\(local)"))
        }
        if let onlyMedia = onlyMedia {
            queryItems.append(URLQueryItem(name: "only_media", value: "\(onlyMedia)"))
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
        if let limit = limit {
            queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
        }
        return Request(path: "/api/v1/timelines/tag/\(hashtag)", httpMethod: .get(queryItems))
    }

    public static func home(
        maxID: String? = nil,
        sinceID: String? = nil,
        minID: String? = nil,
        limit: Int? = nil,
        local: Bool? = nil
    ) -> Request<Paginated<[Responses.Status]>> {
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
        if let local = local {
            queryItems.append(URLQueryItem(name: "local", value: "\(local)"))
        }
        return Request(path: "/api/v1/timelines/home", httpMethod: .get(queryItems))
    }
}
