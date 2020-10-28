extension Requests {
    public enum Timelines {
        public static func home(pagination: Pagination.Item? = nil) -> PageableRequest<[Responses.Toot]> {
            var parameters: [String: String]?
            if let pagination = pagination {
                parameters = [pagination.key: pagination.value]
            }
            return PageableRequest(path: "/api/v1/timelines/home", httpMethod: .get, parameters: parameters)
        }

        public static func `public`(
            local: Bool = false,
            pagination: Pagination.Item? = nil
        ) -> PageableRequest<[Responses.Toot]> {
            var parameters: [String: String] = [
                "local": "\(local)",
            ]
            if let pagination = pagination {
                parameters[pagination.key] = pagination.value
            }
            return PageableRequest(path: "/api/v1/timelines/public", httpMethod: .get, parameters: parameters)
        }

        public static func tag(
            _ tag: Responses.Tag,
            pagination: Pagination.Item? = nil
        ) -> PageableRequest<[Responses.Toot]> {
            var parameters: [String: String]?
            if let pagination = pagination {
                parameters = [pagination.key: pagination.value]
            }
            return PageableRequest(path: "/api/v1/timelines/tag/\(tag.name)", httpMethod: .get, parameters: parameters)
        }
    }
}
