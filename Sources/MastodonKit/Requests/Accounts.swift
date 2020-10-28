extension Requests {
    public struct Account {
        private let id: String

        public init(id: String) {
            self.id = id
        }
    }
}

extension Requests.Account {
    public func followers(pagination: Pagination.Item? = nil) -> PageableRequest<[Responses.Account]> {
        let parameters: [String: String]?
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        } else {
            parameters = nil
        }
        return PageableRequest(
            path: "/api/v1/accounts/\(id)/followers",
            httpMethod: .get,
            parameters: parameters
        )
    }

    public func following(pagination: Pagination.Item? = nil) -> PageableRequest<[Responses.Account]> {
        let parameters: [String: String]?
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        } else {
            parameters = nil
        }
        return PageableRequest(
            path: "/api/v1/accounts/\(id)/following",
            httpMethod: .get,
            parameters: parameters
        )
    }

    public func pinnedToots() -> Request<[Responses.Toot]> {
        Request(path: "/api/v1/accounts/\(id)/statuses", httpMethod: .get, parameters: ["pinned": "true"])
    }

    public func toots(
        excludeReplies: Bool,
        onlyMedia: Bool = false,
        pagination: Pagination.Item? = nil
    ) -> PageableRequest<[Responses.Toot]> {
        var parameters = [
            "exclude_replies": "\(excludeReplies)",
            "only_media": "\(onlyMedia)",
        ]
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        }
        return PageableRequest(
            path: "/api/v1/accounts/\(id)/statuses",
            httpMethod: .get,
            parameters: parameters
        )
    }
}
