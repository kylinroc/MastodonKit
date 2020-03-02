public enum Timeline {
    public static func home(pagination: Pagination<Toot>? = nil) -> Request<[Toot]> {
        var parameters: [String: String] = [:]
        if let pagination = pagination {
            switch pagination {
            case .olderThan(let toot), .newerThan(let toot), .immediatelyNewer(let toot):
                parameters[pagination.key] = toot.id
            }
        }
        return Request(path: "/api/v1/timelines/home", httpMethod: .get, parameters: parameters)
    }

    public static func `public`(
        local: Bool = false,
        onlyMedia: Bool = false,
        limit: Int = 20
    ) -> Request<[Toot]> {
        Request(path: "/api/v1/timelines/public", httpMethod: .get, parameters: [
            "local": "\(local)",
            "only_media": "\(onlyMedia)",
            "limit": "\(limit)",
        ])
    }
}
