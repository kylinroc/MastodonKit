public enum Endpoints {
    public static func following(of account: Account, pagination: Pagination.Item? = nil) -> PageableRequest<[Account]> {
        let parameters: [String: String]?
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        } else {
            parameters = nil
        }
        return PageableRequest(
            path: "/api/v1/accounts/\(account.id)/following",
            httpMethod: .get,
            parameters: parameters
        )
    }

    public static func followers(of account: Account, pagination: Pagination.Item? = nil) -> PageableRequest<[Account]> {
        let parameters: [String: String]?
        if let pagination = pagination {
            parameters = [pagination.key: pagination.value]
        } else {
            parameters = nil
        }
        return PageableRequest(
            path: "/api/v1/accounts/\(account.id)/followers",
            httpMethod: .get,
            parameters: parameters
        )
    }

    public static func account(id: String) -> Request<Account> {
        Request(path: "/api/v1/accounts/\(id)", httpMethod: .get, parameters: nil)
    }
}

extension Endpoints {
    public enum Timelines {
        public static func home(pagination: Pagination.Item? = nil) -> PageableRequest<[Toot]> {
            var parameters: [String: String]?
            if let pagination = pagination {
                parameters = [pagination.key: pagination.value]
            }
            return PageableRequest(path: "/api/v1/timelines/home", httpMethod: .get, parameters: parameters)
        }

        public static func `public`(
            local: Bool = false,
            pagination: Pagination.Item? = nil
        ) -> PageableRequest<[Toot]> {
            var parameters: [String: String] = [
                "local": "\(local)",
            ]
            if let pagination = pagination {
                parameters[pagination.key] = pagination.value
            }
            return PageableRequest(path: "/api/v1/timelines/public", httpMethod: .get, parameters: parameters)
        }

        public static func tag(_ tag: Tag, pagination: Pagination.Item? = nil) -> PageableRequest<[Toot]> {
            var parameters: [String: String]?
            if let pagination = pagination {
                parameters = [pagination.key: pagination.value]
            }
            return PageableRequest(path: "/api/v1/timelines/tag/\(tag.name)", httpMethod: .get, parameters: parameters)
        }
    }
}
