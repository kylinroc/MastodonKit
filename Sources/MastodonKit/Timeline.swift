public enum Timeline {
    public static func home(pagination: Pagination<Toot>? = nil) -> Request<[Toot]> {
        var parameters: [String: String]?
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value.id]
        }
        return Request(path: "/api/v1/timelines/home", httpMethod: .get, parameters: parameters)
    }

    public static func `public`(
        local: Bool = false,
        pagination: Pagination<Toot>? = nil
    ) -> Request<[Toot]> {
        var parameters: [String: String] = [
            "local": "\(local)",
        ]
        if let pagination = pagination {
            parameters[pagination.key] = pagination.value.id
        }
        return Request(path: "/api/v1/timelines/public", httpMethod: .get, parameters: parameters)
    }
}
